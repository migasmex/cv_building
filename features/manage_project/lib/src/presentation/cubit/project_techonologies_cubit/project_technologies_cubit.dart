import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_technologies_state.dart';

class ProjectTechnologiesCubit extends Cubit<ProjectTechnologiesState> {
  final FetchProjectTechnologiesUseCase _fetchProjectTechnologiesUseCase;

  ProjectTechnologiesCubit({
    required FetchProjectTechnologiesUseCase fetchProjectTechnologiesUseCase,
  })  : _fetchProjectTechnologiesUseCase = fetchProjectTechnologiesUseCase,
        super(
          ProjectTechnologiesState(),
        ) {
    fetchProjectTechnologies();
  }

  Future<void> fetchProjectTechnologies() async {
    final List<ProjectTechnologyModel> technologyStack =
        await _fetchProjectTechnologiesUseCase.execute();

    emit(
      state.copyWith(
        technologyStack: technologyStack,
      ),
    );
  }
}
