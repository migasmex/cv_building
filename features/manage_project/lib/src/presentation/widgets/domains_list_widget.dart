import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../cubit/domain_cubit/domain_cubit.dart';
import 'domain_projects_widget.dart';

class DomainsListWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const DomainsListWidget({
    required this.titleController,
    required this.descriptionController,
    super.key,
  });

  Future<void> _onDomainSelected(
    BuildContext context,
    String domain,
  ) async {
    await BlocProvider.of<DomainCubit>(context).loadDomainProjects(
      domain,
    );

    if (!context.mounted) return;

    final List<ProjectReviewModel>? domainProjects =
        BlocProvider.of<DomainCubit>(context).state.domainProjects;

    await AutoRouter.of(context).maybePop();

    if (!context.mounted) return;

    if (domainProjects != null) {
      await showDialog(
        context: context,
        builder: (_) => DomainProjectsWidget(
          domainProjects: domainProjects,
          titleController: titleController,
          descriptionController: descriptionController,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DomainCubit>(
      create: (_) => DomainCubit(
        getDomainProjectsUseCase: appLocator<GetDomainProjectsUseCase>(),
        getDomainsUseCase: appLocator<GetDomainsUseCase>(),
      ),
      child: BlocBuilder<DomainCubit, DomainState>(
        builder: (
          BuildContext context,
          DomainState state,
        ) {
          return AlertDialog(
            title: Text(
              context.locale.selectDomain,
              style: TextStyle(
                color: AppColors.of(context).black,
              ),
            ),
            content: state.domains == null
                ? Center(
                    child: Text(
                      context.locale.noDomainsFound,
                      style: AppFonts.appTextStyle.copyWith(
                        color: AppColors.of(context).black,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: state.domains!.map((DomainModel domain) {
                        return ListTile(
                          title: Text(domain.name),
                          onTap: () => _onDomainSelected(
                            context,
                            domain.name,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
            actions: <Widget>[
              TextButton(
                onPressed: () => AutoRouter.of(context).maybePop(),
                child: Text(
                  context.locale.back,
                  style: TextStyle(
                    color: AppColors.of(context).black,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
