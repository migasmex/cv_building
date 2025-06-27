import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'domain_state.dart';

class DomainCubit extends Cubit<DomainState> {
  final GetDomainsUseCase _getDomainsUseCase;
  final GetDomainProjectsUseCase _getDomainProjectsUseCase;

  DomainCubit({
    required GetDomainsUseCase getDomainsUseCase,
    required GetDomainProjectsUseCase getDomainProjectsUseCase,
  })  : _getDomainsUseCase = getDomainsUseCase,
        _getDomainProjectsUseCase = getDomainProjectsUseCase,
        super(
          DomainState(),
        ) {
    loadDomains();
  }

  Future<void> loadDomains() async {
    final List<DomainModel> domains = await _getDomainsUseCase.execute();

    emit(
      state.copyWith(
        domains: domains,
      ),
    );
  }

  Future<void> loadDomainProjects(
    String domain,
  ) async {
    final List<ProjectReviewModel> projects =
        await _getDomainProjectsUseCase.execute(
      GetDomainProjectsPayload(
        domain: domain,
      ),
    );

    emit(
      state.copyWith(
        domainProjects: projects,
      ),
    );
  }
}
