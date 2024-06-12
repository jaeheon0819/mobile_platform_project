import 'dart:async';

import 'package:flutter/material.dart';
import 'shared_state.dart';

class MyStudyScreen extends StatefulWidget {
  @override
  _MyStudyScreenState createState() => _MyStudyScreenState();
}

class _MyStudyScreenState extends State<MyStudyScreen> {
  int _selectedIndex = 1;
  TextEditingController _courseController = TextEditingController();
  Timer? _timer;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/myStudy');
        break;
    }
  }

  void _toggleCourseStatus(String courseName) {
    courseNotifier.toggleCourseStatus(courseName);
  }

  void _addCourse() {
    String newCourse = _courseController.text;
    if (newCourse.isNotEmpty) {
      courseNotifier.addCourse(newCourse);
      _courseController.clear();
    }
  }

  void _deleteCourse(String courseName) {
    courseNotifier.deleteCourse(courseName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Study",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "오늘의 공부 시간",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "3시간 30분",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "오늘의 일정",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  ValueListenableBuilder<List<Course>>(
                    valueListenable: courseNotifier,
                    builder: (context, List<Course> courses, child) {
                      return Column(
                        children: courses.map((course) {
                          return ListTile(
                            title: InkWell(
                              onTap: () => print('${course.name} tapped'),
                              child: Text(course.name),
                            ),
                            subtitle: Text("과제"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    course.isStudying ? Icons.pause : Icons.play_arrow,
                                  ),
                                  onPressed: () => _toggleCourseStatus(course.name),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteCourse(course.name),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _courseController,
                            decoration: InputDecoration(
                              labelText: '과목명을 입력하세요',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _addCourse,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
