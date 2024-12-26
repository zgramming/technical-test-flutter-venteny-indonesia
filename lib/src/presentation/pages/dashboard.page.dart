// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:technical_test_venteny_indonesia/src/config/constant.dart';
import 'package:technical_test_venteny_indonesia/src/config/enum.dart';

import '../../config/font.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> openFormModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return const FormTask();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _HeaderProfile(),
                const SizedBox(height: 32),
                _RowTitle(
                  actionText: 'See all',
                  title: 'Pending (99+)',
                  onActionPressed: () {},
                ),
                const SizedBox(height: 16),
                const _PendingTasks(),
                const SizedBox(height: 32),
                _RowTitle(
                  actionText: 'See all',
                  title: 'Completed (99+)',
                  onActionPressed: () {},
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemExtent: 150,
                  padding: const EdgeInsets.only(bottom: 100),
                  itemBuilder: (context, index) =>
                      _CompletedTaskItem(index: index),
                )
              ],
            ),
          ),
          // Button to add new task
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: openFormModal,
              child: const Icon(FontAwesomeIcons.plus),
            ),
          )
        ],
      ),
    );
  }
}

class FormTask extends StatefulWidget {
  final bool isEdit;
  final String? id;
  const FormTask({
    super.key,
    this.isEdit = false,
    this.id,
  });

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;
  TaskStatus selectedStatus = TaskStatus.pending;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
              ...[
                const SizedBox(height: 16),
                Text(
                  widget.isEdit ? 'Edit Task' : 'Add New Task',
                  textAlign: TextAlign.center,
                  style: headerFont.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Divider(),
              const SizedBox(height: 16),
              ...[
                Text(
                  "Title",
                  style: bodyFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Enter title',
                    hintStyle: bodyFont.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ],
              // Description
              const SizedBox(height: 16),
              ...[
                Text(
                  "Description",
                  style: bodyFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Enter description',
                    hintStyle: bodyFont.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
              // Date & Time
              const SizedBox(height: 16),
              ...[
                Text(
                  "Date",
                  style: bodyFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        this.selectedDate = selectedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.calendarDay, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          selectedDate == null
                              ? 'Select Date'
                              : DateFormat('E, dd MMM yyyy')
                                  .format(selectedDate!),
                          style: bodyFont.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              // Status
              const SizedBox(height: 16),
              ...[
                Text(
                  "Status",
                  style: bodyFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...TaskStatus.values.mapIndexed<Widget>(
                      (index, status) {
                        // Button style
                        final buttonStyle = ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            selectedStatus == status
                                ? Colors.orange
                                : Colors.grey[200],
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );

                        // Adding space between buttons
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: TaskStatus.values.length - 1 == index
                                    ? 0
                                    : 8),
                            child: TextButton(
                              onPressed: () =>
                                  setState(() => selectedStatus = status),
                              style: buttonStyle,
                              child: Text(
                                status.toString().split('.').last.toUpperCase(),
                                style: bodyFont.copyWith(
                                  fontSize: 12,
                                  color: selectedStatus == status
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],

              // Button
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.isEdit ? 'Update Task' : 'Add Task',
                  style: bodyFont.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletedTaskItem extends StatelessWidget {
  final int index;
  const _CompletedTaskItem({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final randomColor = Colors.primaries[index % Colors.primaries.length];

    final nowPlusIndex = DateTime.now().add(Duration(days: index));
    final formattedDate = DateFormat('E, dd MMM yyyy').format(nowPlusIndex);

    return Card(
      margin: EdgeInsets.only(
        bottom: index == 9 ? 0 : 16,
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 10,
                  decoration: BoxDecoration(
                    color: randomColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Project Name",
                                    maxLines: 1,
                                    style: headerFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, varius velit. Integer ut turpis sit amet purus.",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bodyFont.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: randomColor,
                              child: const Icon(
                                FontAwesomeIcons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(
                          formattedDate,
                          style: bodyFont.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PendingTasks extends StatelessWidget {
  const _PendingTasks();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemExtent: 300,
        padding: const EdgeInsets.only(
          bottom: 8,
        ),
        itemBuilder: (context, index) {
          return _PendingTaskItem(index: index);
        },
      ),
    );
  }
}

class _PendingTaskItem extends StatelessWidget {
  final int index;
  const _PendingTaskItem({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final nowPlusIndex = DateTime.now().add(Duration(days: index));

    final formattedDate = DateFormat('E, dd MMM yyyy').format(nowPlusIndex);
    final randomColor = Colors.primaries[index % Colors.primaries.length];
    return Card(
      margin: EdgeInsets.only(
        right: index == 9 ? 0 : 16,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Project Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: headerFont.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.calendarDay,
                                size: 12,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                formattedDate,
                                style: bodyFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: randomColor,
                      child: const Icon(
                        FontAwesomeIcons.clock,
                        size: 16,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, varius velit. Integer ut turpis sit amet purus.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: bodyFont.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 10,
            decoration: BoxDecoration(
                color: randomColor.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
          )
        ],
      ),
    );
  }
}

class _RowTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionPressed;
  const _RowTitle({
    required this.title,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: headerFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onActionPressed,
          child: Text(
            actionText,
            style: bodyFont.copyWith(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}

class _HeaderProfile extends StatelessWidget {
  const _HeaderProfile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blue,
          child: Icon(
            FontAwesomeIcons.user,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: bodyFont.copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              'John Doe',
              style: bodyFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
