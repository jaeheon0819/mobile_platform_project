import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Course {
  String name;
  Duration studyTime;
  bool isStudying;

  Course({
    required this.name,
    this.studyTime = Duration.zero,
    this.isStudying = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'studyTime': studyTime.inSeconds,
    'isStudying': isStudying,
  };

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      studyTime: Duration(seconds: json['studyTime']),
      isStudying: json['isStudying'],
    );
  }
}

class CourseNotifier extends ValueNotifier<List<Course>> {
  CourseNotifier() : super([]) {
    _loadCourses();
  }

  void addCourse(String name) {
    value.add(Course(name: name));
    _saveCourses();
    notifyListeners();
  }

  void toggleCourseStatus(String name) {
    for (var course in value) {
      if (course.name == name) {
        course.isStudying = !course.isStudying;
      } else {
        course.isStudying = false;
      }
    }
    _saveCourses();
    notifyListeners();
  }

  Duration getTotalStudyTime() {
    Duration totalTime = Duration.zero;
    for (var course in value) {
      totalTime += course.studyTime;
    }
    return totalTime;
  }

  void updateCourseTime(String name, Duration time) {
    for (var course in value) {
      if (course.name == name) {
        course.studyTime = time;
      }
    }
    _saveCourses();
    notifyListeners();
  }

  void resetAllCourseTimes() {
    for (var course in value) {
      course.studyTime = Duration.zero;
    }
    _saveCourses();
    notifyListeners();
  }

  Duration get yesterdayStudyTime {
    // 어제 공부한 시간 계산 로직을 여기에 추가할 수 있습니다.
    return Duration(hours: 3, minutes: 30); // 예시로 3시간 30분 설정
  }

  Future<void> _saveCourses() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> coursesJson = value.map((course) => jsonEncode(course.toJson())).toList();
    await prefs.setStringList('courses', coursesJson);
  }

  Future<void> _loadCourses() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? coursesJson = prefs.getStringList('courses');
    if (coursesJson != null) {
      value = coursesJson.map((courseJson) => Course.fromJson(jsonDecode(courseJson))).toList();
    }
  }
}

final courseNotifier = CourseNotifier();
