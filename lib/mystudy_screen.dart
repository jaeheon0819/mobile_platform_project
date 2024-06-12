import 'package:flutter/material.dart';
import 'dart:async';

class MyStudyScreen extends StatefulWidget {
  const MyStudyScreen({Key? key}) : super(key: key);

  @override
  _MyStudyScreenState createState() => _MyStudyScreenState();
}

class _MyStudyScreenState extends State<MyStudyScreen> {
  int _selectedIndex = 1;
  Map<String, Timer?> _timers = {};
  Map<String, Duration> _durations = {
    // '운영체제과제': Duration.zero,
    // '모바일플랫폼': Duration.zero,
    // '오픈소스활용': Duration.zero,
    // '모플과제1': Duration.zero,
    // '토익강의': Duration.zero,
  };
  Duration _totalTime = Duration.zero;
  String? _currentSubject;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/myStudy');
        break;
      case 2:
        Navigator.pushNamed(context, '/group');
        break;
      case 3:
        Navigator.pushNamed(context, '/community');
        break;
      case 4:
        Navigator.pushNamed(context, '/setting');
        break;
    }
  }

  void _startTimer(String subject) {
    _stopAllTimers();
    setState(() {
      _currentSubject = subject;
    });
    _timers[subject] = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _durations[subject] = _durations[subject]! + const Duration(seconds: 1);
        _calculateTotalTime();
      });
    });
  }

  void _stopTimer(String subject) {
    _timers[subject]?.cancel();
    setState(() {
      _currentSubject = null;
    });
  }

  void _stopAllTimers() {
    _timers.forEach((subject, timer) {
      timer?.cancel();
    });
  }

  void _calculateTotalTime() {
    _totalTime = Duration.zero;
    _durations.forEach((subject, duration) {
      _totalTime += duration;
    });
  }

  void _addNewTask(String title) {
    setState(() {
      _durations[title] = Duration.zero;
    });
  }

  void _deleteTask(String title) {
    setState(() {
      _durations.remove(title);
      _timers.remove(title);
      if (_currentSubject == title) {
        _currentSubject = null;
      }
      _calculateTotalTime();
    });
  }

  @override
  void dispose() {
    _stopAllTimers();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03174C),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Group 6887.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Text(
                    'My Study',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Mask Group.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _formatDuration(_totalTime),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w200, // 더 얇게 설정
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._durations.keys.map((title) {
                    bool isActive = _currentSubject == title;
                    return _buildStudyItem(title, _durations[title]!, isActive);
                  }).toList(),
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
        showUnselectedLabels: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddTaskDialog() {
    String title = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFBAC8FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            '새 항목',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          content: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFD6E4FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              title = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '취소',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  _addNewTask(title);
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBAC8FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '추가',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStudyItem(String title, Duration duration, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          _stopTimer(title);
        } else {
          _startTimer(title);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.blue[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                if (duration != Duration.zero) ...[
                  const SizedBox(width: 8),
                  Text(
                    _formatDuration(duration),
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      height: 1.2,
                    ),
                  ),
                ],
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    _deleteTask(title);
                  },
                ),
                Icon(isActive ? Icons.pause : Icons.play_arrow, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
