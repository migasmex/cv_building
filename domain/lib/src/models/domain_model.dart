import 'project_review_model.dart';

class DomainModel {
  final String name;
  final List<ProjectReviewModel> projectReviews;

  DomainModel({
    required this.name,
    required this.projectReviews,
  });
}
