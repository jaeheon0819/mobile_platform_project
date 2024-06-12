import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4;

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

  String nickname = '왕왕준준서서';
  String gender = '';
  String department = '';
  String studentId = '';

  void _editSetting(String title, String currentValue, Function(String) onSave) {
    TextEditingController _controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter new $title'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  onSave(_controller.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectGender() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildGenderOption('남성'),
              _buildGenderOption('여성'),
            ],
          ),
        );
      },
    );
  }

  void _selectDepartment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Department'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildDepartmentOption('소프트웨어학과'),
              _buildDepartmentOption('정보통계학과'),
              _buildDepartmentOption('컴퓨터공학과'),
              _buildDepartmentOption('산업보안학과'),
              _buildDepartmentOption('모바일시스템학과'),
            ],
          ),
        );
      },
    );
  }

  void _ervicelaw() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildGenderOption('남성'),
              _buildGenderOption('여성'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderOption(String value) {
    return ListTile(
      title: Text(value),
      trailing: gender == value ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          gender = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildDepartmentOption(String value) {
    return ListTile(
      title: Text(value),
      trailing: department == value ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          department = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildSettingItem(String title, String value, Function onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => onTap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 비활성화
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingItem('닉네임', nickname, () {
              _editSetting('닉네임', nickname, (newNickname) {
                nickname = newNickname;
              });
            }),
            _buildSettingItem('성별', gender, _selectGender),
            _buildSettingItem('학과', department, _selectDepartment),
            _buildSettingItem('학번', studentId, () {
              _editSetting('학번', studentId, (newStudentId) {
                studentId = newStudentId;
              });
            }),
            Spacer(),
            TextButton(
              onPressed: () {
                // Implement logout functionality
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '로그아웃',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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