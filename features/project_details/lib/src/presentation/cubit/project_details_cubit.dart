import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'project_details_state.dart';
part 'project_details_state_status.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  final GetProjectUseCase _getProjectUseCase;

  ProjectDetailsCubit({
    required GetProjectUseCase getProjectUseCase,
    required String id,
  })  : _getProjectUseCase = getProjectUseCase,
        super(
          ProjectDetailsState(),
        ) {
    fetchProject(
      id: id,
    );
  }

  Future<void> fetchProject({
    required String id,
  }) async {
    try {
      emit(
        state.copyWith(
          status: ProjectDetailsStateStatus.loading,
        ),
      );

      final GetProjectPayload payload = GetProjectPayload(projectId: id);

      final ProjectModel project = await _getProjectUseCase.execute(payload);

      emit(
        state.copyWith(
          status: ProjectDetailsStateStatus.loaded,
          project: project,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ProjectDetailsStateStatus.failure,
          errorText: e.toString(),
        ),
      );
    }
  }
}
