import 'project_review_entity.dart';

class DomainEntity {
  final String name;
  final List<ProjectReviewEntity> projectReviews;

  DomainEntity({
    required this.name,
    required this.projectReviews,
  });
}
