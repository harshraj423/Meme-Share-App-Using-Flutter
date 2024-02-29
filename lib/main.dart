import 'package:flutter/material.dart';
import 'package:meme_share/view/mainScreen.dart';
import 'package:meme_share/view/splashScreen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool showSplash = true;
  showSplashScreen(){
    Future.delayed(const Duration(seconds: 5),(){
setState(() {
  showSplash = false;
});
    });
  }

  @override
  void initState() {
    showSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemeShare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: showSplash ? const splashScreen() : const MainScreen(),
    );
  }
}

