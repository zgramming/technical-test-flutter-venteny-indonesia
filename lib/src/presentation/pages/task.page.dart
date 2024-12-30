import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../config/color.dart';
import '../../config/enum.dart';
import '../../config/font.dart';
import '../cubit/task.cubit.dart';
import '../cubit/task_filter_query.cubit.dart';
import '../widgets/modal_filter_task.widget.dart';
import '../widgets/modal_form_task.widget.dart';
import '../widgets/row_title.widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _loadData() {
    context.read<TaskCubit>().get();
  }

  Future<void> openFormModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const ModalFormTask();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskFilterQueryCubit, TaskFilterQueryState>(
          listener: (context, state) {
            final query = state.query;
            final status = state.status;
            context.read<TaskCubit>().filter(query: query, status: status);
          },
        ),
      ],
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SearchBar(),
                    ],
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is TaskLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is TaskErrorState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error),
                              const SizedBox(height: 8),
                              Text(state.message),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _loadData,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      final tasks = (state as TaskSuccessState).filteredTasks;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                RowTitle(title: "Total Task ${tasks.length}"),
                                const SizedBox(height: 16),
                                if (tasks.isEmpty) ...[
                                  const Center(
                                    child: Text('No Task Found'),
                                  )
                                ],
                                ListView.separated(
                                  itemCount: tasks.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16.0),
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    final taskStatus =
                                        TaskStatus.values.firstWhereOrNull(
                                      (element) => element.name == task.status,
                                    );
                                    Color color = Colors.grey;
                                    IconData icon = FontAwesomeIcons.check;

                                    final isCompleted =
                                        taskStatus == TaskStatus.completed;
                                    final isProgress =
                                        taskStatus == TaskStatus.progress;
                                    final isPending =
                                        taskStatus == TaskStatus.pending;

                                    if (isCompleted) {
                                      color = Colors.green;
                                      icon = FontAwesomeIcons.circleCheck;
                                    } else if (isProgress) {
                                      color = Colors.blue;
                                      icon = FontAwesomeIcons.arrowsRotate;
                                    } else if (isPending) {
                                      color = Colors.amber;
                                      icon = FontAwesomeIcons.solidClock;
                                    }

                                    final formattedDate =
                                        DateFormat('E, dd MMM yyyy')
                                            .format(task.dueDate);

                                    return Card(
                                      margin: EdgeInsets.zero,
                                      child: InkWell(
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return ModalFormTask(
                                                isEdit: true,
                                                id: task.id,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border(
                                              left: BorderSide(
                                                color: color,
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Text(
                                                          task.title,
                                                          maxLines: 1,
                                                          style: headerFont
                                                              .copyWith(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                          task.description,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              bodyFont.copyWith(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor: color,
                                                    child: Icon(
                                                      icon,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              const Divider(),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    formattedDate,
                                                    style: bodyFont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await context
                                                          .read<TaskCubit>()
                                                          .delete(task.id);
                                                    },
                                                    icon: const Icon(
                                                      FontAwesomeIcons.trash,
                                                      size: 16,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),

                          // Filter Button
                          Positioned(
                            right: 16,
                            bottom: 80,
                            child: FloatingActionButton(
                              key: const Key('filter_button'),
                              heroTag: 'filter_button',
                              onPressed: () async {
                                await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) => const ModalFilterTask(),
                                );
                              },
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                FontAwesomeIcons.filter,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Add Button
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: FloatingActionButton(
                              key: const Key('add_task_button'),
                              heroTag: 'add_task_button',
                              backgroundColor: primaryColor,
                              onPressed: openFormModal,
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  void onSearch(String val) {
    context.read<TaskFilterQueryCubit>().setQuery(val);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onSearch,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
      ),
    );
  }
}
