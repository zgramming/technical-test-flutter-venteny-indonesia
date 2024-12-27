import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/enum.dart';
import '../../config/font.dart';

class FilterStatus {
  final TaskStatus status;
  final bool isSelected;
  final IconData icon;
  final String? title;
  final String? subtitle;

  FilterStatus({
    required this.status,
    this.isSelected = false,
    required this.icon,
    this.title,
    this.subtitle,
  });
}

class ModalFilterTask extends StatefulWidget {
  const ModalFilterTask({
    super.key,
  });

  @override
  State<ModalFilterTask> createState() => _ModalFilterTaskState();
}

class _ModalFilterTaskState extends State<ModalFilterTask> {
  final statuses = [
    FilterStatus(
      status: TaskStatus.pending,
      icon: FontAwesomeIcons.solidClock,
      subtitle: 'Task status is pending',
      title: 'Pending',
    ),
    FilterStatus(
      status: TaskStatus.progress,
      icon: FontAwesomeIcons.arrowsRotate,
      subtitle: 'Task status is in progress',
      title: 'In Progress',
    ),
    FilterStatus(
      status: TaskStatus.completed,
      icon: FontAwesomeIcons.circleCheck,
      subtitle: 'Task status is completed',
      title: 'Completed',
    ),
  ];

  TaskStatus? selectedStatus;

  Future<void> applyFilter() async {
    Navigator.of(context).pop();
  }

  Future<void> resetFilter() async {
    setState(() => selectedStatus = null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Filter Task',
                textAlign: TextAlign.center,
                style: headerFont.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                "Status",
                style: bodyFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...statuses.map(
                (status) => ListTile(
                  splashColor: Colors.red,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    status.icon,
                    size: 16,
                    color: selectedStatus == status.status
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  selected: selectedStatus == status.status,
                  title: Text(
                    "${status.title}",
                    style: bodyFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: selectedStatus == status.status
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    "${status.subtitle}",
                    style: bodyFont.copyWith(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    setState(() => selectedStatus = status.status);
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Reset and Apply Button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: resetFilter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: bodyFont.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: applyFilter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: bodyFont.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
