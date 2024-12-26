// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../config/font.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                  itemExtent: 130,
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
              onPressed: () {},
              child: const Icon(FontAwesomeIcons.plus),
            ),
          )
        ],
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
                        const SizedBox(height: 16),
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
                  maxLines: 1,
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
