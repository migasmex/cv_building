import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:cv/cv.gm.dart';
import 'package:cv_request/cv_request.gm.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.gm.dart';
import 'package:manage_project/manage_project.gm.dart';
import 'package:navigation/navigation.dart';

import '../blocs/cv_details_cubit/cv_details_cubit.dart';
import '../utils/project_generation_type.dart';
import '../widgets/add_project_dialog_widget.dart';
import '../widgets/cv_details_body_widget.dart';

@RoutePage()
class CvDetailsPage extends StatefulWidget {
  final String? cvIdToChange;
  final String? projectIdToReplace;
  final String id;
  final String? folderName;
  final bool? isCvForRequest;

  const CvDetailsPage({
    super.key,
    @QueryParam('folderName') this.folderName,
    @PathParam('cvId') this.id = '',
    @QueryParam('cvIdToChange') this.cvIdToChange,
    @QueryParam('projectIdToReplace') this.projectIdToReplace,
    @QueryParam('isCvForRequest') this.isCvForRequest,
  });

  @override
  State<CvDetailsPage> createState() => _CvDetailsPageState();
}

class _CvDetailsPageState extends State<CvDetailsPage> {
  Future<void> _addProject(BuildContext context) async {
    final ProjectGenerationType? projectGenerationType =
        await showDialog<ProjectGenerationType>(
      context: context,
      builder: (BuildContext dialogContext) {
        return const AddProjectDialogWidget();
      },
    );

    if (!context.mounted) return;

    if (projectGenerationType == ProjectGenerationType.createNew) {
      await AutoRouter.of(context).replace(
        ManageProjectRoute(
          cvId: widget.id,
        ),
      );
    } else if (projectGenerationType == ProjectGenerationType.chooseExisting) {
      await AutoRouter.of(context).replace(
        HomeRoute(
          cvId: widget.id,
          folderName: widget.folderName,
        ),
      );
    }
  }

  void _goBack(BuildContext context) {
    final PageRouteInfo<dynamic> route;

    if (widget.folderName == null) {
      AutoRouter.of(context).maybePop();
      return;
    } else if (widget.isCvForRequest != null) {
      route = CvRequestRoute();
    } else {
      route = CvRoute(
        folderName: widget.folderName!,
        cvId: widget.cvIdToChange,
      );
    }

    AutoRouter.of(context).replace(
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CvDetailsCubit>(
      create: (BuildContext context) => CvDetailsCubit(
        exportToPdfService: appLocator<ExportToPdfService>(),
        exportToDocxService: appLocator<ExportToDocxService>(),
        getCvUseCase: appLocator<GetCvUseCase>(),
        getAllProjectsByCvId: appLocator<GetAllProjectsByCvIdUseCase>(),
        getProjectUseCase: appLocator<GetProjectUseCase>(),
        addProjectUseCase: appLocator<AddProjectUseCase>(),
        deleteProjectUseCase: appLocator<DeleteProjectUseCase>(),
        id: widget.id,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.locale.cvDetails,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => _goBack(context),
          ),
        ),
        body: CvDetailsBodyWidget(
          id: widget.id,
          cvIdToChange: widget.cvIdToChange,
          projectIdToReplace: widget.projectIdToReplace,
        ),
        floatingActionButton:
            widget.cvIdToChange != null && widget.cvIdToChange!.isNotEmpty
                ? const SizedBox.shrink()
                : BlocBuilder<CvDetailsCubit, CvDetailsState>(
                    builder: (BuildContext context, CvDetailsState state) {
                      return RoundAppButton(
                        title: context.locale.addProject,
                        colors: AppColors.of(context),
                        onPressed: () => _addProject(context),
                      );
                    },
                  ),
      ),
    );
  }
}
