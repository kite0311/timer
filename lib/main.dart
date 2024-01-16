import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/next_page.dart';
import 'package:timer/widgets/button/build_reset_button.dart';
import 'package:timer/widgets/button/build_timer_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _milliSecond = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTimeDisplay(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              BuildTimerButton(
                  text: _isRunning ? 'ストップ' : 'スタート',
                  textColor: _isRunning ? Colors.red : Colors.green,
                  buttonColor: Colors.white10,
                  onPressedStart: toggleTimer,
                  onPressedStop: stopTimer),
              const SizedBox(
                width: 4,
              ),
              BuildResetButton(
                  text: 'リセット',
                  buttonColor: Colors.white10,
                  textColor: Colors.white70,
                  onPressed: resetTimer),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeUnit(_formatMinute()),
        _buildTimeUnit(':'),
        _buildTimeUnit(_formatSecond()),
        _buildTimeUnit('.'),
        _buildTimeUnit(_formatMilliSecond()),
      ],
    );
  }

  Widget _buildTimeUnit(String timeUnit) {
    return Text(
      timeUnit,
      style: const TextStyle(fontSize: 100, color: Colors.white),
    );
  }

  String _formatMinute() {
    int minutes = (_milliSecond / 6000).floor();
    String minute = minutes.toString().padLeft(2, '0');
    return minute;
  }

  String _formatSecond() {
    int seconds = (_milliSecond / 100).floor() % 60;
    String formattedSecond = seconds.toString().padLeft(2, '0');
    return formattedSecond;
  }

  String _formatMilliSecond() {
    String milliSeconds = (_milliSecond % 100).toString().padLeft(2, '0');
    return milliSeconds;
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _milliSecond++;
        });
        if (_milliSecond == 6000) {
          resetTimer();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage()),
          );
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();

    setState(() {
      _milliSecond = 0;
      _isRunning = false;
    });
  }
}
