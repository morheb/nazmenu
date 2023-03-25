import 'package:flutter/material.dart';

import 'package:nazmenuapp/view/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        title: 'My App',
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    );
  }
}
