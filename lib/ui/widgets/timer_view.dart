import 'package:aqua_recovery/ui/widgets/round_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;
  bool isHotPhase = true;
  int hotDuration = 5;
  int coldDuration = 5;
  int laps = 3;

  void initController(int seconds) async {
    controller = AnimationController(
      vsync: this,
    );
    controller.dispose();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: seconds),
    )..addListener(() {
        setState(() {
          if (controller.isCompleted && isHotPhase) {
            // Switch to cold phase
            initController(coldDuration);
            controller.forward(from: 0.0);
            isHotPhase = false;
          } else if (controller.isCompleted && !isHotPhase) {
            // Switch to hot phase
            if (laps > 0) {
              laps--;
              initController(hotDuration);
              controller.forward(from: 0.0);
            }

            isHotPhase = true;
          }
          notify();
        });
      });
    controller.forward();
  }

  String get countText {
    Duration count = (controller.duration! * controller.value) -
        controller.duration! * controller.value.floor();
    return '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void notify() {
    if (countText == '0:00:00') {
      AudioPlayer().play(AssetSource('assets/audio/alert.mp3'));
      Vibrate.feedback(FeedbackType.warning);
    }
  }

  @override
  void initState() {
    super.initState();
    initController(hotDuration);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fbff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          hotDuration = value;
                        });
                      },
                      
                      children: [
                        for (int i = 5; i <= 60; i += 5) Text('$i'),
                      ],
                    ),
                  ),
                  const Text('Hot Duration'),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          laps = value;
                        });
                      },
                      children: [
                        for (int i = 1; i <= 10; i++) Text('$i'),
                      ],
                    ),
                  ),
                  const Text('Laps'),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (value) {
                        setState(
                          () {
                            coldDuration = value;
                          },
                        );
                      },
                      children: [
                        for (int i = 5; i <= 60; i += 5) Text('$i'),
                      ],
                    ),
                  ),
                  const Text('Cold Duration'),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      isHotPhase ? Colors.red : Colors.blue),
                  value: controller.value,
                  strokeWidth: 6,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.isDismissed) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: controller.duration!,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller.duration = time;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: isHotPhase ? Colors.red : Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: const RoundButton(
                    icon: Icons.stop,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
