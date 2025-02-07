import 'package:fiap_hackathon/providers/activity_provider.dart';
import 'package:fiap_hackathon/screens/home/widgets/activity_item_widget.dart';
import 'package:fiap_hackathon/utils/widgets/custom_filled_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentContentWidget extends StatefulWidget {
  const StudentContentWidget({super.key});

  @override
  State<StudentContentWidget> createState() => _StudentContentWidgetState();
}

class _StudentContentWidgetState extends State<StudentContentWidget> {
  late ActivityProvider _activityProvider;

  bool _isLoading = false;

  @override
  void initState() {
    _activityProvider = Provider.of(context, listen: false);

    _isLoading = true;
    _activityProvider.getActivities().then((_) {
      setState(() => _isLoading = false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, _, __) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_activityProvider.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Ocorreu um erro'),
                CustomFilledButtonWidget(
                  onPressed: () {
                    setState(() => _isLoading = true);
                    _activityProvider.getActivities().then((_) {
                      setState(() => _isLoading = false);
                    });
                  },
                  title: 'Tentar novamente',
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: _activityProvider.activitiesList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) => ActivityItemWidget(
              activity: _activityProvider.activitiesList[index]),
        );
      },
    );
  }
}
