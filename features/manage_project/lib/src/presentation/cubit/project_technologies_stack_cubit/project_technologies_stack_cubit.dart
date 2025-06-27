import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_technologies_stack_state.dart';

class ProjectTechnologiesStackCubit
    extends Cubit<ProjectTechnologiesStackState> {
  final FetchProjectTechnologiesStackUseCase
      _fetchProjectTechnologiesStackUseCase;

  ProjectTechnologiesStackCubit({
    required FetchProjectTechnologiesStackUseCase
        fetchProjectTechnologiesStackUseCase,
  })  : _fetchProjectTechnologiesStackUseCase =
            fetchProjectTechnologiesStackUseCase,
        super(ProjectTechnologiesStackState()) {
    fetchProjectTechnologiesStack();
  }

  Future<void> fetchProjectTechnologiesStack() async {
    final List<ProjectTechnologyStackModel> technologyStack =
        await _fetchProjectTechnologiesStackUseCase.execute();

    emit(
      state.copyWith(
        technologyStack: technologyStack,
      ),
    );
  }
}
