import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';
import 'package:instagram_flutter/screens/feed_screen.dart';
const mobileScreen = 600;

const homeScreenItems = [
            FeedScreen(),
            Scaffold(body : Text("two"),),
            Scaffold(body : AddPostScreen(),),
            Scaffold(body : Text("four"),),
            Scaffold(body : Text("five"),)
];