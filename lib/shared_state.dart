import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';

class Course {
  String name;
  Duration studyTime;
  bool isStudying;
  Timer? timer;

  Course({required this.name, this.studyTime = Duration.zero, this.isStudying = false});
}

class CourseNotifier extends ValueNotifier<List<Course>> {
  CourseNotifier() : super([]);
  Duration yesterdayStudyTime = Duration.zero;

  UnmodifiableListView<Course> get courses => UnmodifiableListView(value);

  void addCourse(String name) {
    value = [...value, Course(name: name)];
    notifyListeners();
  }

  void deleteCourse(String name) {
    value = value.where((course) => course.name != name).toList();
    notifyListeners();
  }

  void toggleCourseStatus(String name) {
    var course = value.firstWhere((course) => course.name == name);
    if (course.isStudying) {
      course.timer?.cancel();
    } else {
      course.timer = Timer.periodic(Duration(seconds: 1), (timer) {
        course.studyTime += Duration(seconds: 1);
        notifyListeners();
      });
    }
    course.isStudying = !course.isStudying;
    notifyListeners();
  }

  Duration getTotalStudyTime() {
    return value.fold(Duration.zero, (sum, course) => sum + course.studyTime);
  }

  void setYesterdayStudyTime(Duration duration) {
    yesterdayStudyTime = duration;
    notifyListeners();
  }
}

final CourseNotifier courseNotifier = CourseNotifier();
