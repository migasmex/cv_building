abstract class AppConstants {
  static const Duration internetObservingInterval = Duration(seconds: 7);
  static const String internetObservingUrl = 'https://www.google.com/';
  static const String userKey = 'userId';
  static const String basicCvFolderName = 'BasicCVs';
  static const String projectsJsonPath = 'data/lib/src/json_data/projects.json';
  static const String responsibilitiesListJson =
      'data/lib/src/json_data/responsibilities.json';
  static const String technologiesListJson =
      'data/lib/src/json_data/technologies.json';
  static const String technologiesStackListJson =
      'data/lib/src/json_data/technologies_stack.json';
  static const String pdfFooter =
      '''Confidential information Innowise. Distribution without
the written consent of Innowise is strictly forbidden.                         www.innowise.com
''';
  static const int authenticationFailedKey = 1001;
  static const int unknownErrorKey = 1002;
  static const int signInFailedKey = 1003;
  static const int logoutFailedKey = 1004;
  static const int cvDoesntExistsKey = 1005;
  static const int noProjectsFoundKey = 1006;
}
