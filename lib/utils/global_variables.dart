import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

import '../screens/add_post.dart';

const webSreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text('search')),
  AddPostScreen(),
  Center(child: Text('notif')),
  Center(child: Text('profile')),
];

