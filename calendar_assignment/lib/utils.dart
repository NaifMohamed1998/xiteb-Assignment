// ignore_for_file: depend_on_referenced_packages

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


/// Example event class.

class Event {
  final String title;
  final TimeOfDay startTime;
  final String notification;
  final TimeOfDay endTime;
  final String note;

  const Event(
      this.title, this.startTime, this.notification, this.endTime, this.note);
}

Map kEvents = LinkedHashMap<DateTime, List<dynamic>>(
  equals: isSameDay,
  hashCode: getHashCode,
);


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Future<Database> openOrCreateDb() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "my_db.db");
  var db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
      'CREATE TABLE events (id String PRIMARY KEY, name TEXT, date DATE, start_time Time, end_time Time, note TEXT, notification_time String )',
    );
  });
  return db;
}

Future<void> insertEvent(eventName, DateTime date, startTime, endTime, note,
    notificationTime) async {
  String id = Uuid().v4();
  print(id);
  final Database db = await openOrCreateDb();
  await db.execute(
    "INSERT INTO events(id,name, date, start_time,end_time,note,notification_time) VALUES('$id','$eventName', '${date.year}-${date.month}-${date.day}', '${startTime.hour}:${startTime.minute}:00','${endTime.hour}:${endTime.minute}:00','$note','$notificationTime');",
  );
  db.close();
}

Future<void> getEvents() async {
  final Database db = await openOrCreateDb();
  List<Map<String, dynamic>> result = await db.query("'events'");
  db.close();
  for (int i = 0; i < result.length; i++) {
    DateFormat dateFormat = DateFormat("yyyy-mm-dd 00:00:00");
    DateTime date = dateFormat.parse(result[i]['date'] + " 00:00:00");
    print(date);
    String timeString = result[i]['start_time'];
    dateFormat = DateFormat("yyyy-mm-dd hh:mm:ss");
    DateTime dateTime = dateFormat.parse("2000-01-01 " + timeString);
    TimeOfDay startTime = TimeOfDay.fromDateTime(dateTime);

    timeString = result[i]['end_time'];
    dateTime = dateFormat.parse("2000-01-01 " + timeString);
    TimeOfDay endTime = TimeOfDay.fromDateTime(dateTime);

    

    if (kEvents[date] == null) {
      kEvents[date] = [
        Event(result[i]['name'], startTime, result[i]['notification_time'], endTime,
            result[i]['note'])
      ];
    } else {
      kEvents[date].add(Event(result[i]['name'], startTime, result[i]['notification_time'],
          endTime, result[i]['note']));
    }
   
  }
  
}



