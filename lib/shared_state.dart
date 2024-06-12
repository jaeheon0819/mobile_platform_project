import 'package:flutter/material.dart';
import 'dart:async';

class Course {
  String name;
  Duration studyTime;
  bool isStudying;
  Timer? timer;

  Course({
    required this.name,
    this.studyTime = Duration.zero,
    this.isStudying = false,
  });
}

class CourseNotifier extends ValueNotifier<List<Course>> {
  CourseNotifier() : super([]);

  void addCourse(String name) {
    value.add(Course(name: name));
    notifyListeners();
  }

  void toggleCourseStatus(String name) {
    for (var course in value) {
      if (course.name == name) {
        course.isStudying = !course.isStudying;
        if (course.isStudying) {
          course.timer = Timer.periodic(Duration(seconds: 1), (timer) {
            course.studyTime += Duration(seconds: 1);
            notifyListeners();
          });
        } else {
          course.timer?.cancel();
        }
      } else {
        course.isStudying = false;
        course.timer?.cancel();
      }
    }
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
    notifyListeners();
  }

  void resetAllCourseTimes() {
    for (var course in value) {
      course.studyTime = Duration.zero;
    }
    notifyListeners();
  }

  Duration get yesterdayStudyTime {
    // 어제 공부한 시간 계산 로직을 여기에 추가할 수 있습니다.
    return Duration(hours: 3, minutes: 30); // 예시로 3시간 30분 설정
  }
}

final courseNotifier = CourseNotifier();
