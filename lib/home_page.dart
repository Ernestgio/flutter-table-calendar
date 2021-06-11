import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_app/event.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  CalendarFormat _format = CalendarFormat.month;
  Map<DateTime, List<Event>> _events = LinkedHashMap(
    equals: isSameDay,
  );

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events[DateTime.utc(2021, 6, 8)] = [Event(title: 'Do Tasks')];
    _events[DateTime.utc(2021, 6, 9)] = [Event(title: 'Do Tasks 1')];
    _events[DateTime.utc(2021, 6, 10)] = [Event(title: 'Do Tasks 2')];
  }

  List<Event> _getEventsFromDay(DateTime date) {
    return _events[date] ?? [];
  }

  void addEvent(DateTime day, Event newEvent) {
    if (_events[day] != null) {
      _events[day].add(newEvent);
    } else {
      _events[day] = [newEvent];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calendar App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddPage(
                                addEvents: addEvent,
                                selectedDay: _selectedDay)));
                  },
                  child: Text('Add'),
                ),
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2010),
                  lastDay: DateTime(2030),
                  calendarFormat: _format,
                  onFormatChanged: (newFormat) {
                    setState(() {
                      _format = newFormat;
                    });
                  },
                  eventLoader: _getEventsFromDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    print(_selectedDay);
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                ..._getEventsFromDay(_selectedDay).map(
                  (Event event) {
                    return ListTile(
                      title: Text(event.title),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
