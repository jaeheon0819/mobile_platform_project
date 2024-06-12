import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String nickname = '왕왕준준서서';
  String statusMessage = '';
  String category = '';
  String region = '';
  String language = '';

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

  void _selectCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildCategoryOption('SW융합대학'),
              _buildCategoryOption('사회과학대학'),
              _buildCategoryOption('문과대학'),
              _buildCategoryOption('사범대학'),
            ],
          ),
        );
      },
    );
  }

  void _selectRegion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Region'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildRegionOption('SOUTH KOREA'),
              _buildRegionOption('USA'),
              _buildRegionOption('CANADA'),
              _buildRegionOption('JAPAN'),
              _buildRegionOption('CHINA'),
              _buildRegionOption('FRANCE'),
              _buildRegionOption('GERMANY'),
              _buildRegionOption('UK'),
              _buildRegionOption('AUSTRALIA'),
              _buildRegionOption('INDIA'),
            ],
          ),
        );
      },
    );
  }

  void _selectLanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildLanguageOption('한국어'),
              _buildLanguageOption('English'),
              _buildLanguageOption('日本語'),
              _buildLanguageOption('中文'),
              _buildLanguageOption('Français'),
              _buildLanguageOption('Deutsch'),
              _buildLanguageOption('Español'),
              _buildLanguageOption('Italiano'),
              _buildLanguageOption('Русский'),
              _buildLanguageOption('Português'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryOption(String value) {
    return ListTile(
      title: Text(value),
      trailing: category == value ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          category = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildRegionOption(String value) {
    return ListTile(
      title: Text(value),
      trailing: region == value ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          region = value;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildLanguageOption(String value) {
    return ListTile(
      title: Text(value),
      trailing: language == value ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          language = value;
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
            _buildSettingItem('상태 메시지', statusMessage, () {
              _editSetting('상태 메시지', statusMessage, (newStatusMessage) {
                statusMessage = newStatusMessage;
              });
            }),
            _buildSettingItem('카테고리', category, _selectCategory),
            _buildSettingItem('지역선택', region, _selectRegion),
            _buildSettingItem('언어선택', language, _selectLanguage),
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
            label: 'Co'
                'mmunity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: 4,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation bar tap
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/myStudy');
              break;
          // Add other cases for Group Study and Community if needed
            case 4:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}