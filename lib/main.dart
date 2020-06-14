import 'package:flutter/material.dart';
import 'package:tiktok_flutter/screens/home.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         // Uncomment in phase 3 to apply white to text
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white
        ),
      ),
      home: Home(),
    );
  }
}