import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../config/enum.dart';
import '../../config/font.dart';

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
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
