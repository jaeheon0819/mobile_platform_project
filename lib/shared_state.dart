import 'dart:collection';
import 'package:flutter/material.dart';

class Course {
  String name;
  Duration studyTime;
  bool isStudying;

  Course({required this.name, this.studyTime = Duration.zero, this.isStudying = false});
}

class CourseNotifier extends ValueNotifier<List<Course>> {
  CourseNotifier() : super([]);

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
    course.isStudying = !course.isStudying;
    notifyListeners();
  }

  void updateStudyTime(String name, Duration studyTime) {
    var course = value.firstWhere((course) => course.name == name);
    course.studyTime += studyTime;
    notifyListeners();
  }
}

final CourseNotifier courseNotifier = CourseNotifier();
