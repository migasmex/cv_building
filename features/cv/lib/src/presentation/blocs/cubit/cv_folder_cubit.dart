import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../utils/params/filter_cv_params.dart';

part 'cv_folder_state.dart';

class CvFolderCubit extends Cubit<CvFolderState> {
  Timer? searchDebounce;
  final GetAllCvsUseCase _getAllCvsUseCase;
  final AddCvForRequestUseCase _addCvForRequestUseCase;
  final CurrentUserIdUseCase currentUserIdUseCase;

  CvFolderCubit({
    required String folderName,
    required GetAllCvsUseCase getAllCvsUseCase,
    required AddCvForRequestUseCase addCvForRequestUseCase,
    required List<String>? domains,
    required double? experienceInYears,
    required this.currentUserIdUseCase,
  })  : _getAllCvsUseCase = getAllCvsUseCase,
        _addCvForRequestUseCase = addCvForRequestUseCase,
        super(
          CvFolderState(),
        ) {
    applyFilters(
      query: '',
      experienceInYears: experienceInYears,
      domains: domains,
      folderName: folderName,
    );
  }

  List<CvModel> allCvs = <CvModel>[];

  Future<void> applyFilters({
    required String query,
    required List<String>? domains,
    required double? experienceInYears,
    required String folderName,
  }) async {
    emit(
      state.copyWith(
        status: CvFolderStateStatus.loading,
      ),
    );
    allCvs = await _getAllCvsUseCase.execute();
    allCvs = await _filterCvsIntoFolders(
      folderName: folderName,
      allCvs: allCvs,
    );

    searchDebounce?.cancel();
    searchDebounce = Timer(
      const Duration(milliseconds: 200),
      () => _performFiltering(
        query: query,
        domains: domains,
        experienceInYears: experienceInYears,
      ),
    );
  }

  Future<void> _performFiltering({
    required String query,
    required List<String>? domains,
    required double? experienceInYears,
  }) async {
    try {
      List<CvModel> filteredCvs = <CvModel>[];
      final FilterCvsParams filterCvsParams = FilterCvsParams(
        experienceInYears: experienceInYears ?? 0,
        domains: domains ?? <String>[],
        searchQuery: query,
      );
      filteredCvs = await _filterCvs(
        filterCvsParams: filterCvsParams,
      );
      emit(
        state.copyWith(
          filteredCvs: filteredCvs,
          status: CvFolderStateStatus.loaded,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvFolderStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }

  Future<List<CvModel>> _filterCvs({
    required FilterCvsParams filterCvsParams,
  }) async {
    final double experienceInYears = filterCvsParams.experienceInYears;
    final String query = filterCvsParams.searchQuery;
    final List<String> filterDomains = filterCvsParams.domains;

    allCvs = allCvs
        .where(
          (CvModel cv) => cv.title.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();

    allCvs = allCvs.where(
          (CvModel cv) => filterDomains.every(
            (String domain) => cv.domains.contains(domain),
      ),
    ).toList();

    return allCvs
        .where((CvModel cv) => cv.experience >= experienceInYears)
        .toList();
  }

  Future<List<CvModel>> _filterCvsIntoFolders({
    required String folderName,
    required List<CvModel> allCvs,
  }) async {
    if (folderName == AppConstants.basicCvFolderName) {
      return allCvs.where((CvModel cv) => cv.isBasic).toList();
    }
    return allCvs
        .where(
          (CvModel cv) => cv.createdAt.year == int.parse(folderName),
        )
        .toList();
  }

  Future<void> addNewCvRequest(CvModel cvModel) async {
    try {
      final String userId = currentUserIdUseCase.execute(
        const NoParams(),
      );

      final AddCvForRequestPayload payload = AddCvForRequestPayload(
        cvModel: cvModel,
        userId: userId,
      );

      await _addCvForRequestUseCase.execute(
        payload,
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CvFolderStateStatus.failure,
          errorText: '$e',
        ),
      );
    }
  }
}
