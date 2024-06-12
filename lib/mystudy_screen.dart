import 'package:flutter/material.dart';

class MyStudyScreen extends StatefulWidget {
  @override
  _MyStudyScreenState createState() => _MyStudyScreenState();
}

class _MyStudyScreenState extends State<MyStudyScreen> {
  int _selectedIndex = 1;

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
    // 추가적인 화면이 있다면 여기 추가
    }
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
                  ListTile(
                    title: Text("운영체제 과제"),
                    subtitle: Text("과제"),
                    trailing: Icon(Icons.play_arrow),
                  ),
                  ListTile(
                    title: Text("모바일 플랫폼"),
                    subtitle: Text("9:00 - 12:00"),
                    trailing: Icon(Icons.pause),
                  ),
                  ListTile(
                    title: Text("오픈 소스 활용"),
                    subtitle: Text("13:00 - 16:00"),
                    trailing: Icon(Icons.play_arrow),
                  ),
                  ListTile(
                    title: Text("모플 과제1"),
                    subtitle: Text("과제"),
                    trailing: Icon(Icons.play_arrow),
                  ),
                  ListTile(
                    title: Text("토익 강의"),
                    subtitle: Text("20:00 - 21:00"),
                    trailing: Icon(Icons.play_arrow),
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
