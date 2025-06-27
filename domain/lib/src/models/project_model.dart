import 'package:intl/intl.dart';

class ProjectModel {
  final String? id;
  final String cvId;
  final String title;
  final String description;
  final String role;
  final String period;
  final List<String> environment;
  final List<String> achievementList;

  ProjectModel({
    this.id,
    required this.cvId,
    required this.title,
    required this.description,
    required this.role,
    required this.period,
    required this.environment,
    required this.achievementList,
  });

  DateTime _parseDate(String dateStr) {
    final DateFormat formatter = DateFormat('MM.yyyy');
    return formatter.parse(dateStr);
  }

  static Map<String, Map<String, List<dynamic>>> calculateExperienceBySection(
    List<ProjectModel> projects,
    Map<String, List<String>> sectionTechnologies,
  ) {
    final Map<String, Map<String, List<dynamic>>> experienceBySection =
        <String, Map<String, List<dynamic>>>{};

    for (final ProjectModel project in projects) {
      final List<String> period = project.period.split(' – ');
      final DateTime startDate = project._parseDate(period[0]);
      final DateTime endDate = project._parseDate(period[1]);

      final int projectDurationInMonths = (endDate.year - startDate.year) * 12 +
          endDate.month -
          startDate.month +
          1;

      final List<String> technologies = project.environment;

      for (final String technology in technologies) {
        for (final String section in sectionTechnologies.keys) {
          if (sectionTechnologies[section]!.contains(technology)) {
            experienceBySection.putIfAbsent(
              section,
              () => <String, List<dynamic>>{},
            );

            experienceBySection[section]!
                .putIfAbsent(technology, () => <dynamic>[0.0, 0]);

            final double experience = projectDurationInMonths / 12;
            final double roundedExperience =
                (experience * 2).roundToDouble() / 2;

            final Map<String, List<dynamic>> sectionMap =
                experienceBySection[section]!;
            final List<dynamic> technologyExperience = sectionMap[technology]!;

            technologyExperience[0] += roundedExperience;
            technologyExperience[1] = endDate.year;
          }
        }
      }
    }

    return experienceBySection;
  }
}
