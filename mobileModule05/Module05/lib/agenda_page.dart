import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda extends StatefulWidget {
  const Agenda({
    super.key,
  });

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {

  var _focusedDay = DateTime.now();
  var _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(

      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      focusedDay: _focusedDay,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      locale: 'en_US',
      onDaySelected: (selectedDay, focusedDay) => setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      }),
      calendarStyle: const CalendarStyle(
        todayDecoration:  BoxDecoration(color: Color.fromARGB(255, 235, 128, 121) , shape: BoxShape.circle),
        selectedDecoration:  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        
      ),
    );
  }
}
