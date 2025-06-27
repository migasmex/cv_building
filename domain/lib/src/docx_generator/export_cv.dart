import 'dart:html' as html;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:docx_template/docx_template.dart';
import 'package:flutter/services.dart';

import '../models/cv_model.dart';
import '../models/project_model.dart';
import '../remote_config/remote_config_service.dart';

class ExportToDocxService {
  final RemoteConfigService _remoteConfigService;

  ExportToDocxService({
    required RemoteConfigService remoteConfigService,
  }) : _remoteConfigService = remoteConfigService;

  Future<void> exportCvToDocx(CvModel cv, List<ProjectModel> projects) async {
    final String templatePath = cv.achievements.isNotEmpty
        ? AppTemplates.baseTemplate
        : AppTemplates.baseTemplate;

    final ByteData bytes = await rootBundle.load(
      templatePath,
    );
    final DocxTemplate docx = await DocxTemplate.fromBytes(
      bytes.buffer.asUint8List(),
    );

    final PlainContent headerPlainContent = _generateHeaderPlainContent(
      cv,
      projects,
    );

    final PlainContent plainContentForFirstProject =
        _generatePlainContentForFirstProject(
      projects.first,
    );

    final List<PlainContent> plainContentList =
        projects.skip(1).map(_generatePlainContent).toList();

    final Map<String, dynamic> matrixData =
        _remoteConfigService.fetchJsonFromKey('matrix_data');

    final Map<String, List<String>> sectionTechnologies = matrixData.map(
      (String key, dynamic value) => MapEntry<String, List<String>>(
        key,
        List<String>.from(
          value as List<dynamic>,
        ),
      ),
    );

    final Map<String, Map<String, List<dynamic>>> experienceBySection =
        ProjectModel.calculateExperienceBySection(
      projects,
      sectionTechnologies,
    );

    final PlainContent matrixContent = generateMatrixContent(
      experienceBySection,
    );

    final PlainContent achievementsPlainContent = _generateAchievementsContent(
      cv.achievements,
    );

    final Content content = Content();

    content
      ..add(
        ListContent(
          'plainlist',
          plainContentList,
        ),
      )
      ..add(
        plainContentForFirstProject,
      )
      ..add(
        achievementsPlainContent,
      )
      ..add(
        headerPlainContent,
      )
      ..add(
        matrixContent,
      );

    final List<int>? generatedFile = await docx.generate(content);
    if (generatedFile != null) {
      final html.Blob blob = html.Blob(
        <List<int>>[generatedFile],
      );
      final String url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..download = '${cv.title}_cv.docx'
        ..click();

      html.Url.revokeObjectUrl(url);
    }
  }

  PlainContent _generatePlainContentForFirstProject(ProjectModel project) {
    final PlainContent plainContent = PlainContent('first_project');
    plainContent
      ..add(
        TextContent(
          'title',
          'Projects',
        ),
      )
      ..add(
        TextContent(
          'first_project_name',
          _allWordsCapitilize(
            project.title,
          ),
        ),
      )
      ..add(
        TextContent(
          'first_project_description',
          '${project.description}.',
        ),
      )
      ..add(
        TextContent(
          'first_project_role',
          project.role,
        ),
      )
      ..add(
        TextContent(
          'first_project_period',
          project.period,
        ),
      )
      ..add(
        ListContent(
          'first_project_achievements',
          _generateAchievementsForFirstProject(project),
        ),
      )
      ..add(
        TextContent(
          'first_project_environment',
          '${project.environment.join(', ')}.',
        ),
      );

    return plainContent;
  }

  PlainContent _generatePlainContent(ProjectModel project) {
    final PlainContent plainContent = PlainContent('plainview');

    plainContent
      ..add(
        TextContent(
          'project_name',
          _allWordsCapitilize(
            project.title,
          ),
        ),
      )
      ..add(
        TextContent(
          'project_description',
          '${project.description}.',
        ),
      )
      ..add(
        TextContent(
          'role',
          project.role,
        ),
      )
      ..add(
        TextContent(
          'period',
          project.period,
        ),
      )
      ..add(
        ListContent(
          'achievements',
          _generateAchievements(
            project,
          ),
        ),
      )
      ..add(
        TextContent(
          'environment',
          '${project.environment.join(', ')}.',
        ),
      );

    return plainContent;
  }

  List<Content> _generateAchievements(ProjectModel project) {
    final List<String> achievements = project.achievementList;
    return achievements.asMap().entries.map((MapEntry<int, String> entry) {
      final bool isLast = entry.key == achievements.length - 1;
      final String symbol = isLast ? '.' : ';';
      final String achievement = '${entry.value}$symbol';
      return TextContent(
        'value',
        achievement,
      );
    }).toList();
  }

  List<Content> _generateAchievementsForFirstProject(ProjectModel project) {
    final List<String> achievements = project.achievementList;
    return achievements.asMap().entries.map((MapEntry<int, String> entry) {
      final bool isLast = entry.key == achievements.length - 1;
      final String symbol = isLast ? '.' : ';';
      final String achievement = '${entry.value}$symbol';
      return TextContent(
        'achievement_value',
        achievement,
      );
    }).toList();
  }

  PlainContent _generateHeaderPlainContent(CvModel cv, List<ProjectModel> projects) {

    final Set<String> projectTechnologies =
    projects.expand((ProjectModel project) => project.environment).toSet();
    final List<String> apiTechnologies = _remoteConfigService
        .fetchListFromKey(
      RemoteConfigKeys.apiTechnologies,
    )
        .where(projectTechnologies.contains)
        .toList();
    final List<String> developmentServices = _remoteConfigService
        .fetchListFromKey(
      RemoteConfigKeys.developmentServices,
    )
        .where(projectTechnologies.contains)
        .toList();

    final List<String> others = _remoteConfigService
        .fetchListFromKey(
      RemoteConfigKeys.others,
    )
        .where(projectTechnologies.contains)
        .toList();

    final List<String> programmingLanguages = _remoteConfigService
        .fetchListFromKey(
      RemoteConfigKeys.programmingLanguages,
    )
        .where(projectTechnologies.contains)
        .toList();

    final List<String> programmingTechnologies = _remoteConfigService
        .fetchListFromKey(
      RemoteConfigKeys.programmingTechnologies,
    )
        .where(projectTechnologies.contains)
        .toList();
    final PlainContent plainContent = PlainContent(
      'header_plain',
    );

    plainContent
      ..add(
        TextContent(
          'name',
          cv.title,
        ),
      )
      ..add(
        TextContent(
          'current_role',
          cv.grade,
        ),
      )
      ..add(
        TextContent(
          'education',
          cv.education,
        ),
      )
      ..add(
        TextContent(
          'language',
          cv.language,
        ),
      )
      ..add(
        TextContent(
          'header_description',
          '${cv.selfIntroTitle}.',
        ),
      )
      ..add(
        TextContent(
          'goal',
          '${cv.selfIntro}.',
        ),
      )
      ..add(
        TextContent(
          'languages_list',
          '${programmingLanguages.join(', ')}.',
        ),
      )
      ..add(
        TextContent(
          'technologies',
          '${programmingTechnologies.join(', ')}.',
        ),
      )
      ..add(
        TextContent(
          'development_services',
          '${developmentServices.join(', ')}.',
        ),
      )
      ..add(
        TextContent(
          'api_technologies',
          '${apiTechnologies.join(', ')}.',
        ),
      )
      ..add(
        TextContent(
          'other',
          '${others.join(', ')}.',
        ),
      )
      ..add(
        ListContent(
          'domains_list',
          cv.domains
              .map(
                (String domain) => TextContent(
                  'domain',
                  domain,
                ),
              )
              .toList(),
        ),
      );
    return plainContent;
  }

  PlainContent _generateAchievementsContent(Map<String, String> data) {
    final List<RowContent> rows = <RowContent>[];

    for (final MapEntry<String, String> entry in data.entries) {
      rows.add(
        RowContent()
          ..add(
            TextContent(
              'key1',
              entry.key,
            ),
          )
          ..add(
            TextContent(
              'key2',
              entry.value,
            ),
          ),
      );
    }

    return PlainContent('ach_plain')
      ..add(
        TableContent(
          'ach_table',
          rows,
        ),
      )
      ..add(
        TextContent(
          'ach_title',
          'Achievements',
        ),
      );
  }

  PlainContent generateMatrixContent(
    Map<String, Map<String, List<dynamic>>> experienceBySection,
  ) {
    final List<RowContent> rows = <RowContent>[];

    for (final String section in experienceBySection.keys) {
      final Map<String, List<dynamic>> techMap = experienceBySection[section]!;

      final List<TextContent> technologyList = <TextContent>[];
      final List<TextContent> experienceList = <TextContent>[];
      final List<TextContent> lastUsedList = <TextContent>[];

      for (final String technology in techMap.keys) {
        final List<dynamic> value = techMap[technology]!;
        technologyList.add(
          TextContent(
            'matrix_technology',
            technology,
          ),
        );
        experienceList.add(
          TextContent(
            'matrix_exp',
            value[0].toString(),
          ),
        );
        lastUsedList.add(
          TextContent(
            'matrix_last_used',
            value[1].toString(),
          ),
        );
      }

      rows.add(
        RowContent()
          ..add(
            TextContent(
              'matrix_section',
              section.toUpperCase(),
            ),
          )
          ..add(
            ListContent(
              'mat_tech_list',
              technologyList,
            ),
          )
          ..add(
            ListContent(
              'exp_list',
              experienceList,
            ),
          )
          ..add(
            ListContent(
              'used_list',
              lastUsedList,
            ),
          ),
      );
    }

    return PlainContent('matrix_plain')
      ..add(
        TableContent(
          'matrix_table',
          rows,
        ),
      )
      ..add(
        TextContent(
          'matrix_title',
          'Professional skills',
        ),
      );
  }

  String _allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((String word) {
      final String leftText =
          (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
