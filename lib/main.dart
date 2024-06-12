import 'package:flutter/material.dart';
import 'home_screen.dart'; // 홈 화면
import 'login_screen.dart';

import 'mystudy_screen.dart'; // 공부 기록 화면
// import 'groups_screen.dart'; // 그룹 화면
// import 'community_screen.dart'; // 커뮤니티 화면
// import 'settings_screen.dart'; // 설정 화면
import 'dart:async';



void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/myStudy': (context) => MyStudyScreen(),
        // '/groups': (context) => GroupsScreen(),
      },
    );
  }
}
