import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'cv_details_state.dart';

class CvDetailsCubit extends Cubit<CvDetailsState> {
  final GetCvUseCase getCvUseCase;
  final GetAllProjectsByCvIdUseCase getAllProjectsByCvId;
  final AddProjectUseCase addProjectUseCase;
  final GetProjectUseCase getProjectUseCase;
  final DeleteProjectUseCase deleteProjectUseCase;
  final ExportToDocxService exportToDocxService;
  final ExportToPdfService exportToPdfService;

  CvDetailsCubit({
    required this.getCvUseCase,
    required this.getAllProjectsByCvId,
    required this.getProjectUseCase,
    required this.exportToDocxService,
    required this.exportToPdfService,
    required this.addProjectUseCase,
    required this.deleteProjectUseCase,
    required String id,
  }) : super(CvDetailsInitial()) {
    fetchCv(id);
  }

  Future<void> fetchCv(String id) async {
    try {
      emit(
        CvDetailsLoading(),
      );
      final CvModel cv = await getCvUseCase.execute(id);
      final List<ProjectModel> projects =
          await getAllProjectsByCvId.execute(id);
      emit(
        CvDetailsLoaded(
          cv: cv,
          projects: projects,
        ),
      );
    } catch (e) {
      emit(
        CvDetailsLoadingFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> exportCvToDocx(CvModel cv, List<ProjectModel> projects) async {
    try {
      await exportToDocxService.exportCvToDocx(cv, projects);
    } catch (e) {
      emit(
        CvExportError(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> exportCvToPdf(CvModel cv, List<ProjectModel> projects) async {
    try {
      await exportToPdfService.exportCvToPdf(cv, projects);
    } catch (e) {
      emit(
        CvExportError(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> addProjectToCv(ProjectModel project, String id) async {
    try {
      final ProjectModel projectCopy = ProjectModel(
        cvId: id,
        period: project.period,
        achievementList: project.achievementList,
        environment: project.environment,
        description: project.description,
        role: project.role,
        title: project.title,
      );

      final AddProjectPayload payload = AddProjectPayload(
        projectModel: projectCopy,
      );

      await addProjectUseCase.execute(payload);
    } catch (e) {
      emit(
        CvDetailsLoadingFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteProjectFromCv(String projectId) async {
    try {
      final DeleteProjectPayload payload = DeleteProjectPayload(
        projectId: projectId,
      );

      await deleteProjectUseCase.execute(payload);
    } on Exception catch (e) {
      emit(
        CvDetailsLoadingFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<String> getProjectPeriod(String projectId) async {
    final GetProjectPayload payload = GetProjectPayload(
      projectId: projectId,
    );

    final ProjectModel project = await getProjectUseCase.execute(payload);
    return project.period;
  }
}
