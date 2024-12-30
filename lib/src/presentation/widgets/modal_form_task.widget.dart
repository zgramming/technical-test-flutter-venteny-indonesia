import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../config/color.dart';
import '../../core/helper/function.helper.dart';

import '../../config/enum.dart';
import '../../config/font.dart';
import '../../core/helper/local_notification.helper.dart';
import '../../data/models/dto/task_create_or_update.dto.dart';
import '../cubit/task.cubit.dart';
import '../cubit/task_detail.cubit.dart';

class ModalFormTask extends StatefulWidget {
  final bool isEdit;
  final int? id;
  const ModalFormTask({
    super.key,
    this.isEdit = false,
    this.id,
  });

  @override
  State<ModalFormTask> createState() => _ModalFormTaskState();
}

class _ModalFormTaskState extends State<ModalFormTask> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? selectedDate;
  TaskStatus selectedStatus = TaskStatus.pending;
  bool isLoading = false;

  void _loadData() {
    if (!widget.isEdit) return;

    context.read<TaskDetailCubit>().get(widget.id ?? 0);
  }

  void onSubmit() async {
    final validate = formKey.currentState?.validate() ?? false;

    if (!validate) return;

    final title = titleController.text;
    final description = descriptionController.text;
    final date = selectedDate ?? DateTime.now();
    final status = selectedStatus.toString().split('.').last;

    try {
      setState(() => isLoading = true);
      if (widget.isEdit) {
        final result = await context.read<TaskCubit>().update(
              widget.id ?? 0,
              TaskCreateOrUpdateDto(
                title: title,
                description: description,
                dueDate: date,
                status: status,
              ),
            );

        result.fold(
          (l) {},
          (r) async {
            final id = r.data?.id ?? 0;
            final body = description;

            await LocalNotificationHelper.scheduleNotification(
              id: id,
              title: title,
              body: body,
              scheduledDate: date,
            );
            if (!mounted) return;
            Navigator.of(context).pop();
          },
        );
      } else {
        final result = await context.read<TaskCubit>().add(
              TaskCreateOrUpdateDto(
                title: title,
                description: description,
                dueDate: date,
                status: status,
              ),
            );

        result.fold(
          (l) {},
          (r) async {
            final id = r.data?.id ?? 0;
            final body = description;

            await LocalNotificationHelper.scheduleNotification(
              id: id,
              title: title,
              body: body,
              scheduledDate: date,
            );
            if (!mounted) return;
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      if (!mounted) return;

      FunctionHelper.showSnackBar(context: context, message: "$e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskDetailCubit, TaskDetailState>(
          listener: (context, state) {
            if (state is TaskDetailSuccessState) {
              final task = state.task;
              titleController.text = task.title;
              descriptionController.text = task.description;
              dateController.text =
                  DateFormat('E, dd MMM yyyy').format(task.dueDate);
              selectedDate = task.dueDate;

              selectedStatus = TaskStatus.values.firstWhereOrNull((element) {
                    final status = element.toString().split('.').last;
                    return status == task.status;
                  }) ??
                  TaskStatus.pending;

              setState(() {});
            }
          },
        ),
      ],
      child: BlocBuilder<TaskDetailCubit, TaskDetailState>(
        builder: (context, state) {
          if (state is TaskDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskDetailErrorState) {
            return Center(child: Text(state.message));
          }

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: const InputDecoration(
                            hintText: 'Enter title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
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
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Enter description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                        ),
                      ],
                      // Date & Time
                      const SizedBox(height: 16),
                      ...[
                        Text(
                          "Date",
                          style: bodyFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );

                            if (!context.mounted) return;

                            if (selectedDate != null) {
                              final selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: true,
                                    ),
                                    child: child ?? const SizedBox(),
                                  );
                                },
                              );

                              if (!context.mounted) return;

                              if (selectedTime != null) {
                                setState(() {
                                  this.selectedDate = DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );
                                });

                                final formattedDate =
                                    DateFormat('E, dd MMM yyyy')
                                        .format(selectedDate);
                                final formattedTime =
                                    selectedTime.format(context);

                                dateController.text =
                                    '$formattedDate $formattedTime';
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Select date',
                            prefixIcon: Icon(FontAwesomeIcons.calendarDay),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date is required';
                            }
                            return null;
                          },
                        ),
                      ],

                      // Status
                      const SizedBox(height: 16),
                      ...[
                        Text(
                          "Status",
                          style: bodyFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                                        right: TaskStatus.values.length - 1 ==
                                                index
                                            ? 0
                                            : 8),
                                    child: TextButton(
                                      onPressed: () => setState(
                                          () => selectedStatus = status),
                                      style: buttonStyle,
                                      child: Text(
                                        status
                                            .toString()
                                            .split('.')
                                            .last
                                            .toUpperCase(),
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
                        onPressed: isLoading ? null : onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
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
            ),
          );
        },
      ),
    );
  }
}
