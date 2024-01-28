import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  late Timer _timer;
  int _timeLeft = 30; // example for 30 seconds
  bool _isHot = true; // to toggle between hot and cold

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeLeft == 0) {
          setState(() {
            timer.cancel();
            _isHot = !_isHot; // Switch between hot and cold
            _timeLeft = 30; // Reset timer
            // Play sound and vibrate
            AudioPlayer().play(AssetSource('audio/alert.mp3'));
            Vibrate.feedback(FeedbackType.warning);
          });
        } else {
          setState(() {
            _timeLeft--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Contrast Shower Timer'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // This is where your custom timer UI would go
          Text(
            'Time Left: $_timeLeft',
            style: const TextStyle(fontSize: 48),
          ),
          ElevatedButton(
            onPressed: () {
              startTimer();
            },
            child: const Text('Start Timer'),
          ),
        ],
      ),
    ),
  );
}
}