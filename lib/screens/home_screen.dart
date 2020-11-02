import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:TaskApp/widgets/addTask.dart';
import 'package:TaskApp/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  Future<void> _addNewTask(BuildContext ctx) async {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        context: ctx,
        builder: (_) {
          return Wrap(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: AddTask(ctx),
                ),
                behavior: HitTestBehavior.opaque,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          TableCalendar(
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
              selectedColor: Theme.of(context).accentColor,
              todayColor: Theme.of(context).primaryColor,
            ),
          ),
          TaskList(),
          Expanded(child: SizedBox()),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              FloatingActionButton(
                tooltip: 'Add Task',
                child: Icon(Icons.add),
                onPressed: () => _addNewTask(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
