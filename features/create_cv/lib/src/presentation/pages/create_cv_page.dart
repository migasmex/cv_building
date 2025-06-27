import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:cv/cv.gm.dart';
import 'package:cv_request/cv_request.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../blocs/cubit/create_cv_cubit.dart';
import '../utils/grade.dart';
import '../utils/grade_localization.dart';
import '../widgets/add_achievement_dialog_widget.dart';
import '../widgets/custom_hint_text_field.dart';
import '../widgets/expansion_table_widget.dart';

@RoutePage()
class CreateCvPage extends StatefulWidget {
  final bool? isCvForRequest;
  final String? folderName;

  const CreateCvPage({
    @QueryParam('isCvForRequest') this.isCvForRequest,
    @QueryParam('folderName') this.folderName,
    super.key,
  });

  @override
  State<CreateCvPage> createState() => _CreateCvPageState();
}

class _CreateCvPageState extends State<CreateCvPage> {
  bool _isAchievementsExpanded = false;
  final Map<String, String> _achievements = <String, String>{};

  late final TextEditingController _nameController;
  late final TextEditingController _educationController;
  late final TextEditingController _selfIntroTitleController;
  late final TextEditingController _selfIntroController;
  late final TextEditingController _experienceController;

  List<String> domains = <String>[
    'Entertainment application',
    'E-commerce',
    'Healthcare',
    'Finance',
    'Meditation',
    'Hiring',
    'Transport',
    'Inspection',
    'Dance',
    'Tourism',
  ];

  List<String> languages = <String>[
    'English – B1',
    'English – B2',
    'English – C1',
    'German – B1',
    'German – B2',
    'German – C1',
  ];

  List<String> grades = <String>[];

  bool get isFormValid =>
      _nameController.text.isNotEmpty &&
      _educationController.text.isNotEmpty &&
      _experienceController.text.isNotEmpty &&
      _selfIntroController.text.isNotEmpty &&
      _selfIntroTitleController.text.isNotEmpty &&
      grades.isNotEmpty &&
      domains.isNotEmpty &&
      languages.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _educationController = TextEditingController();
    _selfIntroTitleController = TextEditingController();
    _selfIntroController = TextEditingController();
    _experienceController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    grades = _localizedGrades(context);
  }

  List<String> _localizedGrades(BuildContext context) {
    return Grade.values
        .map((Grade grade) => localizedGrade(context, grade))
        .toList();
  }

  Future<void> _createCv(BuildContext context) async {
    if (!isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.locale.fillInEmptyFields,
          ),
        ),
      );
      return;
    }

    final String name = _nameController.text.trim();
    final String education = _educationController.text.trim();
    final String selfIntroTitle = _selfIntroTitleController.text.trim();
    final String selfIntro = _selfIntroController.text.trim();
    final String experience = _experienceController.text.trim();

    final CreateCvModel createCvModel = CreateCvModel(
      achievements: _achievements,
      title: name,
      education: education,
      grade: grades.first,
      experience: double.parse(experience),
      language: languages.join(', '),
      domains: domains,
      selfIntroTitle: selfIntroTitle,
      selfIntro: selfIntro,
      isBasic: widget.isCvForRequest == false,
      createdAt: DateTime.now(),
    );

    final String? cvId =
        await context.read<CreateCvCubit>().addCv(createCvModel);

    if (!context.mounted) return;

    await _goBack(context, cvId);
  }

  Future<void> _goBack(BuildContext context, String? cvId) async {
    final bool shouldHandleCvRequest = widget.isCvForRequest != null &&
        cvId != null &&
        widget.folderName == null;

    if (shouldHandleCvRequest) {
      return _handleCvRequest(context, cvId);
    }

    return _navigateToFolder(context);
  }

  Future<void> _handleCvRequest(BuildContext context, String cvId) async {
    await context.read<CreateCvCubit>().addNewCvRequest(cvId);

    if (!context.mounted) return;

    await AutoRouter.of(context).replace(CvRequestRoute());
  }

  Future<void> _navigateToFolder(BuildContext context) async {
    await AutoRouter.of(context).replace(
      CvRoute(folderName: widget.folderName!),
    );
  }

  Future<void> _addAchievement() async {
    final MapEntry<String, String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddAchievementDialogWidget();
      },
    );

    if (result != null) {
      setState(() {
        _achievements[result.key] = result.value;
      });
    }
  }

  Future<void> _editAchievementDialog({
    required String key,
    required String value,
  }) async {
    final MapEntry<String, String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAchievementDialogWidget(
          keyText: key,
          valueText: value,
        );
      },
    );

    if (result != null) {
      setState(() {
        _removeAchievement(key);
        _achievements[result.key] = result.value;
      });
    }
  }

  void _removeAchievement(String key) {
    setState(() {
      _achievements.remove(key);
    });
  }

  void _updateGradeValues(List<String> updatedList) {
    grades = updatedList;
  }

  void _updateLanguageValues(List<String> updatedList) {
    languages = updatedList;
  }

  void _updateDomainValues(List<String> updatedList) {
    domains = updatedList;
  }

  void _toggleExpansion(bool isExpanded) {
    setState(() {
      _isAchievementsExpanded = !isExpanded;
    });
  }

  void _editAchievement(String key) {
    _editAchievementDialog(key: key, value: _achievements[key]!);
  }

  void _deleteAchievement(String key) {
    _removeAchievement(key);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocProvider<CreateCvCubit>(
      create: (_) => CreateCvCubit(
        addCvUseCase: appLocator<AddCvUseCase>(),
        getCvUseCase: appLocator<GetCvUseCase>(),
        addCvForRequestUseCase: appLocator<AddCvForRequestUseCase>(),
        currentUserIdUseCase: appLocator<CurrentUserIdUseCase>(),
      ),
      child: Scaffold(
        backgroundColor: colors.white,
        appBar: AppBar(
          backgroundColor: colors.white,
          title: Text(context.locale.createCv),
          centerTitle: true,
        ),
        body: BlocBuilder<CreateCvCubit, CreateCvState>(
          builder: (BuildContext context, CreateCvState state) {
            return ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      const _SizedBoxWidget(),
                      AppTextFieldWidget(
                        labelText: context.locale.enterName,
                        controller: _nameController,
                        width: AppDimens.constraint300,
                      ),
                      const _SizedBoxWidget(),
                      AppTextFieldWidget(
                        labelText: context.locale.enterExperience,
                        controller: _experienceController,
                        width: AppDimens.constraint300,
                      ),
                      const _SizedBoxWidget(),
                      CustomHintTextField(
                        onValuesChanged: _updateGradeValues,
                        suggestions: grades,
                        labelText: context.locale.enterGrade,
                        isSingleInputMode: true,
                      ),
                      const _SizedBoxWidget(),
                      AppTextFieldWidget(
                        labelText: context.locale.enterEducation,
                        controller: _educationController,
                        width: AppDimens.constraint300,
                      ),
                      const _SizedBoxWidget(),
                      CustomHintTextField(
                        onValuesChanged: _updateLanguageValues,
                        suggestions: languages,
                        labelText: context.locale.enterLanguageLevel,
                      ),
                      const _SizedBoxWidget(),
                      CustomHintTextField(
                        onValuesChanged: _updateDomainValues,
                        suggestions: domains,
                        labelText: context.locale.enterDomains,
                      ),
                      const _SizedBoxWidget(),
                      AppTextFieldWidget(
                        labelText: context.locale.enterTextOfSelfIntroTitle,
                        controller: _selfIntroTitleController,
                        width: AppDimens.constraint300,
                      ),
                      const _SizedBoxWidget(),
                      AppTextFieldWidget(
                        labelText: context.locale.enterTextOfSelfIntro,
                        controller: _selfIntroController,
                        width: AppDimens.constraint300,
                      ),
                      const _SizedBoxWidget(),
                      SizedBox(
                        width: AppDimens.constraint800,
                        child: ExpansionTableWidget(
                          achievements: _achievements,
                          isExpanded: _isAchievementsExpanded,
                          onExpansionChanged: _toggleExpansion,
                          onEditAchievement: _editAchievement,
                          onDeleteAchievement: _deleteAchievement,
                        ),
                      ),
                      const _SizedBoxWidget(),
                      AppButton(
                        buttonText: context.locale.createNewCV,
                        buttonWidth: AppDimens.constraint300,
                        buttonHeight: AppDimens.constraint50,
                        onPressed: () => _createCv(context),
                      ),
                      const _SizedBoxWidget(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: SizedBox(
          height: AppDimens.constraint125,
          width: AppDimens.constraint125,
          child: RoundAppButton(
            title: context.locale.addAchievement,
            colors: AppColors.of(context),
            onPressed: _addAchievement,
          ),
        ),
      ),
    );
  }
}

class _SizedBoxWidget extends StatelessWidget {
  const _SizedBoxWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppDimens.padding20,
    );
  }
}
