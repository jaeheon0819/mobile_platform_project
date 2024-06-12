import 'package:flutter/material.dart';
import 'shared_state.dart';
import 'group_screen.dart';
import 'mystudy_screen.dart';
import 'package:intl/intl.dart';  // 날짜 포맷을 위해 intl 패키지 사용

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String todayDate = DateFormat('yyyy MM dd').format(DateTime.now());
  final String todayDay = DateFormat('EEEE').format(DateTime.now());

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
      case 2:
        Navigator.pushReplacementNamed(context, '/group');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/community');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/setting');
        break;
    }
  }

  void _toggleCourseStatus(String courseName) {
    courseNotifier.toggleCourseStatus(courseName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '단국대에서  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset('assets/KakaoTalk_Photo_2024-06-13-02-52-22.png', height: 70),
                    const Text(
                      '  공부할래??',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let's study together!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '오늘도 힘찬 하루를 시작해보아요',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<List<Course>>(
                  valueListenable: courseNotifier,
                  builder: (context, List<Course> courses, child) {
                    Duration totalStudyTime = courseNotifier.getTotalStudyTime();
                    return StudyTimeCard(
                      title: "Today's Study Time",
                      time: _formatDuration(totalStudyTime),
                      date: todayDate,
                      day: todayDay,
                      backgroundColor: Colors.red[100]!,
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<List<Course>>(
                  valueListenable: courseNotifier,
                  builder: (context, List<Course> courses, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              for (var course in courses)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: CourseCard(
                                    title: course.name,
                                    time: _formatDuration(course.studyTime),
                                    buttonText: course.isStudying ? 'STOP' : 'START',
                                    backgroundColor: Colors.orange[100]!,
                                    onPressed: () => _toggleCourseStatus(course.name),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<List<Course>>(
                  valueListenable: courseNotifier,
                  builder: (context, List<Course> courses, child) {
                    Duration yesterdayStudyTime = courseNotifier.yesterdayStudyTime;
                    return StudyTimeCard(
                      title: "Yesterday's Study Time",
                      time: _formatDuration(yesterdayStudyTime),
                      date: todayDate, // 여기서도 같은 날짜를 표시합니다.
                      day: todayDay, // 여기서도 같은 요일을 표시합니다.
                      backgroundColor: Colors.pinkAccent[100]!,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'My Groups',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GroupCard(
                        groupName: 'Group1',
                        members: '4 Members',
                        backgroundColor: Colors.green[100]!,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GroupCard(
                        groupName: 'Group2',
                        members: '7 Members',
                        backgroundColor: Colors.yellow[100]!,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GroupCard(
                        groupName: 'Group3',
                        members: '4 Members',
                        backgroundColor: Colors.green[100]!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}

class StudyTimeCard extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String day;
  final Color backgroundColor;

  const StudyTimeCard({
    required this.title,
    required this.time,
    required this.date,
    required this.day,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$date  |  $day',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String time;
  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CourseCard({
    required this.title,
    required this.time,
    required this.buttonText,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String groupName;
  final String members;
  final Color backgroundColor;

  const GroupCard({
    required this.groupName,
    required this.members,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            members,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}