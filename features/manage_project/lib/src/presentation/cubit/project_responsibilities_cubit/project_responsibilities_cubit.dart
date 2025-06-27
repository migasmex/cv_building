import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_responsibilities_state.dart';

class ProjectResponsibilitiesCubit extends Cubit<ProjectResponsibilitiesState> {
  final FetchLanguagesUseCase _fetchLanguagesUseCase;
  final FetchCategoriesUseCase _getCategoriesUseCase;

  ProjectResponsibilitiesCubit({
    required FetchLanguagesUseCase getLanguagesUseCase,
    required FetchCategoriesUseCase getCategoriesUseCase,
  })  : _fetchLanguagesUseCase = getLanguagesUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(
          ProjectResponsibilitiesState(),
        ) {
    loadLanguages();
  }

  Future<void> loadLanguages() async {
    final List<LanguageModel> languages = await _fetchLanguagesUseCase.execute();

    emit(
      state.copyWith(
        languages: languages,
      ),
    );
  }

  Future<void> loadCategories(String language) async {
    final List<CategoryModel> categories = await _getCategoriesUseCase.execute(
      FetchCategoriesPayload(language: language),
    );

    emit(
      state.copyWith(
        selectedLanguage: language,
        categories: categories,
      ),
    );
  }
}
