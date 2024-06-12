import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int _selectedIndex = 2; // 초기 인덱스를 Group Study로 설정

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
        Navigator.pushNamed(context, '/groupStudy');
        break;
      case 3:
        Navigator.pushNamed(context, '/community');
        break;
      case 4:
        Navigator.pushNamed(context, '/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Group 6876.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Group Study',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3F414E),
                      fontSize: 28,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GroupCard(
                        title: 'Group1',
                        description: 'SW융합대학',
                        members: '4 Members',
                        color: Color(0xFFAFDBC5),
                      ),
                      GroupCard(
                        title: 'Group2',
                        description: 'TOEIC',
                        members: '7 Members',
                        color: Color(0xFFF7E8B6),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GroupCard(
                        title: 'Group3',
                        description: '모바일플랫폼',
                        members: '6 Members',
                        color: Color(0xFFF7E8B6),
                      ),
                      GroupCard(
                        title: 'Group4',
                        description: '운영체제(SW)',
                        members: '10 Members',
                        color: Color(0xFFAFDBC5),
                      ),
                    ],
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
        showUnselectedLabels: true,
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String title;
  final String description;
  final String members;
  final Color color;

  GroupCard({
    required this.title,
    required this.description,
    required this.members,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF3F414E),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Color(0x91231F20),
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.55,
            ),
          ),
          SizedBox(height: 8),
          Text(
            members,
            style: TextStyle(
              color: Color(0x91231F20),
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.2,
              letterSpacing: 0.55,
            ),
          ),
        ],
      ),
    );
  }
}
