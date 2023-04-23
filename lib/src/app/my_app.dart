import 'package:flutter/material.dart';
import 'package:pomodoro/src/presentation/pages/pomodoro.dart';
import 'package:pomodoro/src/domain/models/init.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    init(context);
    return MaterialApp(
      home: const Pomodoro(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
