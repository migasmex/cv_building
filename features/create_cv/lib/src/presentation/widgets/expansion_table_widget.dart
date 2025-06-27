import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ExpansionTableWidget extends StatelessWidget {
  final Map<String, String> achievements;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final Function(String) onEditAchievement;
  final Function(String) onDeleteAchievement;

  const ExpansionTableWidget({
    required this.achievements,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.onEditAchievement,
    required this.onDeleteAchievement,
    Key? key,
  }) : super(key: key);

  Widget _buildHeader(BuildContext context, bool isExpanded) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        context.locale.achievements,
        style: AppFonts.cvCardText.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (achievements.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          context.locale.noAchievements,
          style: AppFonts.cvCardText,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
      children: achievements.entries
          .map(
            _buildAchievementEntry,
          )
          .toList(),
    );
  }

  Widget _buildAchievementEntry(MapEntry<String, String> entry) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              entry.key,
              style: AppFonts.cvCardText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.padding10),
              child: Text(
                entry.value,
                style: AppFonts.cvCardText,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildEditButton(entry.key),
              _buildDeleteButton(entry.key),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(String key) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        onEditAchievement(key);
      },
    );
  }

  Widget _buildDeleteButton(String key) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.black),
      onPressed: () {
        onDeleteAchievement(key);
      },
    );
  }

  void _onExpansionChanged(bool isExpanded) {
    onExpansionChanged(!isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.constraint800,
      child: ExpansionPanelList(
        expandIconColor: AppColors.of(context).black,
        animationDuration: const Duration(milliseconds: 500),
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (int index, bool isExpanded) {
          _onExpansionChanged(isExpanded);
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            backgroundColor: Colors.white,
            canTapOnHeader: true,
            headerBuilder: _buildHeader,
            body: _buildBody(context),
            isExpanded: isExpanded,
          ),
        ],
      ),
    );
  }
}
