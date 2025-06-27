part of 'domain_cubit.dart';

class DomainState {
  final List<DomainModel>? domains;
  final List<ProjectReviewModel>? domainProjects;

  DomainState({
    this.domains,
    this.domainProjects,
  });

  DomainState copyWith({
    List<DomainModel>? domains,
    List<ProjectReviewModel>? domainProjects,

  }) {
    return DomainState(
      domains: domains ?? this.domains,
      domainProjects: domainProjects ?? this.domainProjects,
    );
  }
}
