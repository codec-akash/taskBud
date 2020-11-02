import 'package:TaskApp/providers/auth.dart';
import 'package:TaskApp/providers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TaskApp/screens/auth_screen.dart';
import 'package:TaskApp/screens/bottom_navigation_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Tasks(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Task App',
          theme: ThemeData(
            primaryColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            // brightness: Brightness.dark,
          ),
          home: BottomNavigationScreen(),
          routes: {},
        ),
      ),
    );
  }
}
