import 'package:flutter/material.dart';

class Post {
  final String userName;
  final String title;
  final String content;
  final String tag;

  Post({required this.userName, required this.title, required this.content, required this.tag});
}

class PostNotifier extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }
}