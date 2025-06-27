import 'dart:html' as html;

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/cv_model.dart';
import '../models/project_model.dart';
import '../remote_config/remote_config_service.dart';

class ExportToPdfService {
  final RemoteConfigService _remoteConfigService;

  ExportToPdfService({
    required RemoteConfigService remoteConfigService,
  }) : _remoteConfigService = remoteConfigService;
  Future<void> exportCvToPdf(CvModel cv, List<ProjectModel> projects) async {
    int totalPages = 0;
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

    final ByteData mulishBoldData = await rootBundle.load(
      PdfFonts.mulishBoldFont,
    );
    final pw.Font mulishBold = pw.Font.ttf(
      mulishBoldData,
    );
    final ByteData mulishMediumData = await rootBundle.load(
      PdfFonts.mulishMediumFont,
    );
    final pw.Font mulishMedium = pw.Font.ttf(
      mulishMediumData,
    );
    final ByteData mulishRegularData = await rootBundle.load(
      PdfFonts.mulishRegularFont,
    );
    final pw.Font mulishRegular = pw.Font.ttf(
      mulishRegularData,
    );

    final pw.TextStyle titleStyle = pw.TextStyle(
      color: const PdfColor.fromInt(0xFF303030),
      fontSize: 12,
      font: mulishBold,
    );

    final pw.TextStyle bodyStyle = pw.TextStyle(
      fontSize: 12,
      lineSpacing: 3,
      font: mulishRegular,
    );

    pw.Widget displayCustomText(
      String text,
      pw.TextStyle style,
    ) {
      return pw.Text(
        text,
        style: style,
        textAlign: pw.TextAlign.justify,
      );
    }

    pw.Widget headersText(
      String text,
      pw.TextStyle style,
      pw.TextAlign textAlign,
    ) {
      return pw.Text(
        text,
        style: style.copyWith(
          fontSize: 10,
        ),
        textAlign: textAlign,
      );
    }

    pw.TableRow displayCustomRow({
      required String leftColumnText,
      required String rightColumnText,
      required pw.TextStyle style,
    }) {
      return pw.TableRow(
        children: <pw.Widget>[
          pw.Text(leftColumnText),
          pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding28,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.SizedBox(
                  height: AppDimens.padding17,
                ),
                displayCustomText(
                  rightColumnText,
                  style,
                ),
                pw.SizedBox(
                  height: AppDimens.padding5,
                ),
              ],
            ),
          ),
        ],
      );
    }

    List<List<String>> splitListIntoRows(
      List<String> elements,
      int lineLimit,
    ) {
      final List<List<String>> rows = <List<String>>[];
      final List<String> currentRow = <String>[];
      int currentRowLength = 0;

      for (int i = 0; i < elements.length; i++) {
        final List<String> words = elements[i].split(' ');

        for (int j = 0; j < words.length; j++) {
          String word = words[j];
          if (j == words.length - 1 && i != elements.length - 1) {
            word = '$word,';
          }

          final int wordLength = word.length + (currentRow.isEmpty ? 0 : 1);
          if (currentRowLength + wordLength <= lineLimit) {
            currentRow.add(word);
            currentRowLength += wordLength;
          } else {
            rows.add(
              List<String>.from(currentRow),
            );
            currentRow.clear();

            currentRow.add(word);
            currentRowLength = word.length;
          }
        }
      }

      if (currentRow.isNotEmpty) {
        rows.add(currentRow);
      }

      if (rows.isNotEmpty) {
        final List<String> lastRow = rows.last;
        if (lastRow.isNotEmpty) {
          lastRow[lastRow.length - 1] = '${lastRow.last}.';
        }
      }

      return rows;
    }

    List<List<String>> splitBulletPointsByRatio(List<String> achievements) {
      final int splitIndex = (achievements.length * 0.6).ceil();
      return <List<String>>[
        achievements.sublist(
          0,
          splitIndex,
        ),
        achievements.sublist(
          splitIndex,
        ),
      ];
    }

    List<pw.Widget> buildCv() {
      final List<List<String>> environment = splitListIntoRows(
        others,
        47,
      );
      final List<pw.Widget> content = <pw.Widget>[];
      content
        ..add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
              right: AppDimens.padding10,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.SizedBox(
                  height: AppDimens.padding10,
                ),
                displayCustomText(
                  cv.title,
                  titleStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding10,
                ),
                displayCustomText(
                  cv.grade.toUpperCase(),
                  bodyStyle.copyWith(
                    font: mulishMedium,
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding20,
                ),
              ],
            ),
          ),
        )
        ..add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
              right: AppDimens.padding10,
            ),
            child: pw.Table(
              columnWidths: <int, pw.TableColumnWidth>{
                0: const pw.FractionColumnWidth(0.33),
                1: const pw.FractionColumnWidth(0.67),
              },
              border: const pw.TableBorder(
                verticalInside: pw.BorderSide(
                  width: 0.5,
                  color: PdfColor.fromInt(0xFFc32b3b),
                ),
              ),
              children: <pw.TableRow>[
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        right: AppDimens.padding20,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding15,
                          ),
                          displayCustomText(
                            'Education',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding7,
                          ),
                          displayCustomText(
                            cv.education,
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Language proficiency',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding7,
                          ),
                          displayCustomText(
                            cv.language,
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Domains',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: <pw.Widget>[
                              ...cv.domains.map(
                                (String domain) {
                                  return pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                      bottom: AppDimens.padding3,
                                    ),
                                    child: displayCustomText(
                                      domain,
                                      bodyStyle,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding15,
                          ),
                          displayCustomText(
                            cv.selfIntroTitle,
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding7,
                          ),
                          displayCustomText(
                            cv.selfIntro,
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Programming languages',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                          displayCustomText(
                            programmingLanguages.join(', '),
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Programming technologies',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                          displayCustomText(
                            programmingTechnologies.join(', '),
                            bodyStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Text(
                      '',
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Development Services (third-party services)',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Text(''),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: displayCustomText(
                        developmentServices.join(', '),
                        bodyStyle,
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Text(
                      '',
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'API Technologies',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Text(''),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: displayCustomText(
                        apiTechnologies.join(', '),
                        bodyStyle,
                      ),
                    ),
                  ],
                ),
                displayCustomRow(
                  leftColumnText: '',
                  rightColumnText: 'Others',
                  style: titleStyle,
                ),
                for (final List<String> row in environment)
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Text(''),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                          left: AppDimens.padding28,
                        ),
                        child: pw.Text(
                          row.join(' '),
                          style: bodyStyle,
                          textAlign: pw.TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      if (cv.achievements.isNotEmpty) {
        content
          ..add(
            pw.NewPage(),
          )
          ..add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(
                left: AppDimens.padding20,
                right: AppDimens.padding10,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.SizedBox(
                    height: AppDimens.padding10,
                  ),
                  displayCustomText(
                    'Achievements',
                    titleStyle.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  pw.SizedBox(
                    height: AppDimens.padding10,
                  ),
                ],
              ),
            ),
          )
          ..add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(
                left: AppDimens.padding20,
                right: AppDimens.padding10,
              ),
              child: pw.Table(
                columnWidths: <int, pw.TableColumnWidth>{
                  0: const pw.FractionColumnWidth(0.4),
                  1: const pw.FractionColumnWidth(0.6),
                },
                border: const pw.TableBorder(
                  verticalInside: pw.BorderSide(
                    width: 0.5,
                    color: PdfColor.fromInt(0xFFc32b3b),
                  ),
                ),
                children: <pw.TableRow>[
                  ...cv.achievements.entries.expand(
                    (MapEntry<String, String> entry) => <pw.TableRow>[
                      pw.TableRow(
                        children: <pw.Widget>[
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              right: AppDimens.padding20,
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.SizedBox(
                                  height: AppDimens.padding15,
                                ),
                                pw.Text(
                                  entry.key,
                                  style: titleStyle,
                                ),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: AppDimens.padding28,
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.SizedBox(
                                  height: AppDimens.padding15,
                                ),
                                pw.Text(
                                  entry.value,
                                  style: bodyStyle.copyWith(
                                    lineSpacing: 3,
                                  ),
                                  textAlign: pw.TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
      }
      content
        ..add(
          pw.NewPage(),
        )
        ..add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
              right: AppDimens.padding10,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.SizedBox(
                  height: AppDimens.padding10,
                ),
                displayCustomText(
                  'Projects',
                  titleStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding20,
                ),
              ],
            ),
          ),
        );
      for (final ProjectModel project in projects) {
        final List<List<String>> environment = splitListIntoRows(
          project.environment,
          43,
        );
        final List<List<String>> dividedAchievements = splitBulletPointsByRatio(
          project.achievementList,
        );
        content.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
              right: AppDimens.padding10,
            ),
            child: pw.Table(
              columnWidths: <int, pw.TableColumnWidth>{
                0: const pw.FractionColumnWidth(0.47),
                1: const pw.FractionColumnWidth(0.53),
              },
              border: const pw.TableBorder(
                verticalInside: pw.BorderSide(
                  width: 0.5,
                  color: PdfColor.fromInt(0xFFc32b3b),
                ),
              ),
              children: <pw.TableRow>[
                pw.TableRow(
                  children: <pw.Widget>[
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        right: AppDimens.padding35,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding15,
                          ),
                          displayCustomText(
                            project.title,
                            titleStyle.copyWith(
                              color: const PdfColor.fromInt(0xFFc32b3b),
                            ),
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding15,
                          ),
                          displayCustomText(
                            '${project.description}.',
                            bodyStyle,
                          ),
                        ],
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(
                        left: AppDimens.padding28,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: AppDimens.padding15,
                          ),
                          displayCustomText(
                            'Project roles',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding7,
                          ),
                          displayCustomText(
                            project.role,
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Period',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                          displayCustomText(
                            project.period,
                            bodyStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding17,
                          ),
                          displayCustomText(
                            'Responsibilities & achievements',
                            titleStyle,
                          ),
                          pw.SizedBox(
                            height: AppDimens.padding5,
                          ),
                          ...dividedAchievements[0].map(
                            (String achievement) => pw.Bullet(
                              bulletMargin: const pw.EdgeInsets.only(
                                top: 1.9 * PdfPageFormat.mm,
                                left: 3.0 * PdfPageFormat.mm,
                                right: 2.5 * PdfPageFormat.mm,
                              ),
                              bulletColor: const PdfColor.fromInt(0xFFc32b3b),
                              text: '$achievement;',
                              style: bodyStyle,
                              textAlign: pw.TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                for (final String achievement in dividedAchievements[1])
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Text(''),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                          left: AppDimens.padding28,
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Bullet(
                              bulletMargin: const pw.EdgeInsets.only(
                                top: 1.9 * PdfPageFormat.mm,
                                left: 3.0 * PdfPageFormat.mm,
                                right: 2.5 * PdfPageFormat.mm,
                              ),
                              bulletColor: const PdfColor.fromInt(0xFFc32b3b),
                              text:
                                  '$achievement${achievement == dividedAchievements[1].last ? '.' : ';'}',
                              style: bodyStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                displayCustomRow(
                  leftColumnText: '',
                  rightColumnText: 'Environment',
                  style: titleStyle,
                ),
                for (final List<String> row in environment)
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Text(''),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                          left: AppDimens.padding28,
                        ),
                        child: pw.Text(
                          row.join(' '),
                          style: bodyStyle,
                          textAlign: pw.TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
        if (project != projects.last) {
          content
            ..add(
              pw.NewPage(),
            )
            ..add(
              pw.SizedBox(
                height: AppDimens.padding10,
              ),
            );
        }
      }
      return content;
    }

    pw.Widget generateTable(
      Map<String, Map<String, List<dynamic>>> experienceBySection,
    ) {
      final List<pw.TableRow> tableRows = <pw.TableRow>[];

      for (final String section in experienceBySection.keys) {
        final Map<String, List<dynamic>> techMap =
            experienceBySection[section]!;

        final List<pw.Widget> technologyColumn = <pw.Widget>[];
        final List<pw.Widget> experienceColumn = <pw.Widget>[];
        final List<pw.Widget> lastUsedColumn = <pw.Widget>[];

        for (final String technology in techMap.keys) {
          final List<dynamic> value = techMap[technology]!;

          technologyColumn.addAll(
            <pw.Widget>[
              pw.Text(
                technology,
                style: titleStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(
                height: AppDimens.padding10,
              ),
            ],
          );
          experienceColumn.addAll(
            <pw.Widget>[
              pw.Text(
                value[0].toString(),
                style: bodyStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(
                height: AppDimens.padding10,
              ),
            ],
          );
          lastUsedColumn.addAll(
            <pw.Widget>[
              pw.Text(
                value[1].toString(),
                style: bodyStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(
                height: AppDimens.padding10,
              ),
            ],
          );
        }

        tableRows.add(
          pw.TableRow(
            children: <pw.Widget>[
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                  left: AppDimens.padding10,
                  top: AppDimens.padding10,
                ),
                child: displayCustomText(
                  section.toUpperCase(),
                  titleStyle.copyWith(
                    fontSize: 10,
                    color: const PdfColor.fromInt(0xFFc32b3b),
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                  right: AppDimens.padding10,
                  left: AppDimens.padding70,
                  top: AppDimens.padding10,
                  bottom: AppDimens.padding10,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: technologyColumn,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                  left: AppDimens.padding5,
                  top: AppDimens.padding10,
                  bottom: AppDimens.padding10,
                ),
                child: pw.Column(
                  children: experienceColumn,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                  left: AppDimens.padding30,
                  top: AppDimens.padding10,
                  bottom: AppDimens.padding10,
                ),
                child: pw.Column(
                  children: lastUsedColumn,
                ),
              ),
            ],
          ),
        );
      }

      return pw.Padding(
        padding: const pw.EdgeInsets.only(
          left: AppDimens.padding8,
          right: AppDimens.padding8,
        ),
        child: pw.Table(
          columnWidths: <int, pw.TableColumnWidth>{
            0: const pw.FractionColumnWidth(0.2),
            1: const pw.FractionColumnWidth(0.4),
            2: const pw.FractionColumnWidth(0.2),
            3: const pw.FractionColumnWidth(0.2),
          },
          border: const pw.TableBorder(
            horizontalInside: pw.BorderSide(
              width: 0.5,
              color: PdfColor.fromInt(0xFFc32b3b),
            ),
          ),
          children: tableRows,
        ),
      );
    }

    final pw.Document pdf = pw.Document();
    final String svg = await rootBundle.loadString(
      AppImages.innowiseImage,
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          margin: pw.EdgeInsets.symmetric(
            horizontal: AppDimens.padding24,
            vertical: AppDimens.padding16,
          ),
        ),
        footer: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                displayCustomText(
                  AppConstants.pdfFooter,
                  bodyStyle.copyWith(
                    fontSize: 9,
                    color: const PdfColor.fromInt(0xdfdfdf),
                    lineSpacing: 2,
                  ),
                ),
                displayCustomText(
                  context.pageNumber.toString(),
                  bodyStyle.copyWith(
                    fontSize: 9,
                    color: const PdfColor.fromInt(0xdfdfdf),
                  ),
                ),
              ],
            ),
          );
        },
        header: (pw.Context context) {
          totalPages = context.pagesCount;
          return pw.Column(
            children: <pw.Widget>[
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Opacity(
                  opacity: 0.7,
                  child: pw.SvgImage(
                    svg: svg,
                    height: AppDimens.constraint10,
                    width: AppDimens.constraint80,
                  ),
                ),
              ),
              pw.Divider(
                color: const PdfColor.fromInt(0xFFe2969e),
                thickness: 0.5,
              ),
            ],
          );
        },
        build: (pw.Context context) {
          return buildCv();
        },
      ),
    );

    final pw.Document pdfFinal = pw.Document();

    pdfFinal.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          margin: pw.EdgeInsets.symmetric(
            horizontal: AppDimens.padding24,
            vertical: AppDimens.padding16,
          ),
        ),
        header: (pw.Context context) {
          if (context.pageNumber == totalPages + 1) {
            return pw.Column(
              children: <pw.Widget>[
                pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Opacity(
                    opacity: 0.7,
                    child: pw.SvgImage(
                      svg: svg,
                      height: AppDimens.constraint10,
                      width: AppDimens.constraint80,
                    ),
                  ),
                ),
                pw.Divider(
                  color: const PdfColor.fromInt(0xFFe2969e),
                  thickness: 0.5,
                ),
                pw.SizedBox(
                  height: AppDimens.padding10,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: AppDimens.padding20,
                    right: AppDimens.padding10,
                  ),
                  child: pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: displayCustomText(
                      'Professional skills',
                      titleStyle.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding30,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: AppDimens.padding20,
                    right: AppDimens.padding10,
                  ),
                  child: pw.Row(
                    children: <pw.Widget>[
                      headersText(
                        'SKILLS',
                        titleStyle,
                        pw.TextAlign.center,
                      ),
                      pw.SizedBox(
                        width: AppDimens.padding290,
                      ),
                      pw.SizedBox(
                        width: AppDimens.constraint80,
                        child: pw.Column(
                          children: <pw.Widget>[
                            pw.SizedBox(
                              height: AppDimens.padding15,
                            ),
                            pw.Wrap(
                              children: <pw.Widget>[
                                headersText(
                                  'EXPERIENCE IN YEARS',
                                  titleStyle,
                                  pw.TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: AppDimens.padding50,
                      ),
                      headersText(
                        'LAST USED',
                        titleStyle,
                        pw.TextAlign.center,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding7,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: AppDimens.padding8,
                    right: AppDimens.padding8,
                  ),
                  child: pw.Divider(
                    thickness: 1.5,
                    color: const PdfColor.fromInt(0xFFc32b3b),
                  ),
                ),
              ],
            );
          } else if (context.pageNumber > (totalPages + 1)) {
            return pw.Column(
              children: <pw.Widget>[
                pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Opacity(
                    opacity: 0.7,
                    child: pw.SvgImage(
                      svg: svg,
                      height: AppDimens.constraint10,
                      width: AppDimens.constraint80,
                    ),
                  ),
                ),
                pw.Divider(
                  color: const PdfColor.fromInt(0xFFe2969e),
                  thickness: 0.5,
                ),
                pw.SizedBox(
                  height: AppDimens.padding10,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: AppDimens.padding20,
                    right: AppDimens.padding10,
                  ),
                  child: pw.Row(
                    children: <pw.Widget>[
                      headersText(
                        'SKILLS',
                        titleStyle.copyWith(
                          fontSize: 10,
                        ),
                        pw.TextAlign.center,
                      ),
                      pw.SizedBox(
                        width: AppDimens.padding290,
                      ),
                      pw.SizedBox(
                        width: AppDimens.constraint80,
                        child: pw.Column(
                          children: <pw.Widget>[
                            pw.SizedBox(
                              height: AppDimens.padding15,
                            ),
                            pw.Wrap(
                              children: <pw.Widget>[
                                headersText(
                                  'EXPERIENCE IN YEARS',
                                  titleStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                  pw.TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        width: AppDimens.padding50,
                      ),
                      headersText(
                        'LAST USED',
                        titleStyle.copyWith(
                          fontSize: 10,
                        ),
                        pw.TextAlign.center,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: AppDimens.padding7,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: AppDimens.padding8,
                    right: AppDimens.padding8,
                  ),
                  child: pw.Divider(
                    thickness: 2,
                    color: const PdfColor.fromInt(0xFFe2969e),
                  ),
                ),
              ],
            );
          }
          return pw.Column(
            children: <pw.Widget>[
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Opacity(
                  opacity: 0.7,
                  child: pw.SvgImage(
                    svg: svg,
                    height: AppDimens.constraint10,
                    width: AppDimens.constraint80,
                  ),
                ),
              ),
              pw.Divider(
                color: const PdfColor.fromInt(0xFFe2969e),
                thickness: 0.5,
              ),
            ],
          );
        },
        build: (pw.Context context) {
          final List<pw.Widget> content = <pw.Widget>[];

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

          content
            ..addAll(
              buildCv(),
            )
            ..add(
              pw.NewPage(),
            )
            ..add(
              generateTable(
                experienceBySection,
              ),
            );
          return content;
        },
        footer: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(
              left: AppDimens.padding20,
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                displayCustomText(
                  AppConstants.pdfFooter,
                  bodyStyle.copyWith(
                    fontSize: 9,
                    color: const PdfColor.fromInt(0xdfdfdf),
                    lineSpacing: 2,
                  ),
                ),
                displayCustomText(
                  context.pageNumber.toString(),
                  bodyStyle.copyWith(
                    fontSize: 9,
                    color: const PdfColor.fromInt(0xdfdfdf),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final Uint8List generatedFile1 = await pdfFinal.save();

    final html.Blob blob = html.Blob(<List<int>>[generatedFile1]);
    final String url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..download = '${cv.title}_CV.pdf'
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
