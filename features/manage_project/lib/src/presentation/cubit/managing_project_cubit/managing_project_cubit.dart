import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'managing_project_state.dart';

class ManagingProjectCubit extends Cubit<ManagingProjectState> {
  final String? projectId;
  final AddProjectUseCase _addProjectUseCase;
  final GetProjectUseCase _getProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;

  ManagingProjectCubit({
    required this.projectId,
    required AddProjectUseCase addProjectUseCase,
    required UpdateProjectUseCase updateProjectUseCase,
    required GetProjectUseCase getProjectUseCase,
  })  : _addProjectUseCase = addProjectUseCase,
        _updateProjectUseCase = updateProjectUseCase,
        _getProjectUseCase = getProjectUseCase,
        super(
          ManagingProjectState(),
        ) {
    if (projectId != null && projectId!.isNotEmpty) {
      getProject(projectId!);
    }
  }

  Future<void> getProject(
    String id,
  ) async {
    try {
      final GetProjectPayload payload = GetProjectPayload(projectId: id);

      final ProjectModel project = await _getProjectUseCase.execute(payload);

      emit(
        state.copyWith(
          project: project,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorText: e.toString(),
        ),
      );
    }
  }

  Future<void> addProject(ProjectModel projectModel) async {
    try {
      final AddProjectPayload payload = AddProjectPayload(
        projectModel: projectModel,
      );

      await _addProjectUseCase.execute(payload);

    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorText: e.toString(),
        ),
      );
    }
  }

  Future<void> editProject(ProjectModel projectModel) async {
    try {
      final UpdateProjectPayload payload = UpdateProjectPayload(
        projectModel: projectModel,
      );

      await _updateProjectUseCase.execute(payload);
      
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorText: e.toString(),
        ),
      );
    }
  }
}
