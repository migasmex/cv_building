part of 'project_responsibilities_cubit.dart';

class ProjectResponsibilitiesState {
  final List<LanguageModel>? languages;
  final List<CategoryModel>? categories;
  final String? selectedLanguage;

  ProjectResponsibilitiesState({
    this.languages,
    this.categories,
    this.selectedLanguage,
  });

  ProjectResponsibilitiesState copyWith({
    List<LanguageModel>? languages,
    List<CategoryModel>? categories,
    String? selectedLanguage,
  }) {
    return ProjectResponsibilitiesState(
      languages: languages ?? this.languages,
      categories: categories ?? this.categories,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
