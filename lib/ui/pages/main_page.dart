import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var timeForShowerBeforeBed = const TimeOfDay(hour: 21, minute: 0);
  var timeForShowerAfterWakeUp = const TimeOfDay(hour: 9, minute: 0);
  var isEnabledNotificationBeforeBed = true;
  var isEnabledNotificationAfterWakeUp = true;

  @override
  Widget build(BuildContext context) {
    final day = TimeOfDay.fromDateTime(DateTime.now());

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                icon: const Icon(Icons.home_filled)),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              icon: const Icon(Icons.trending_up_rounded),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                icon: const Icon(Icons.settings))
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timur Kharin,',
                      style: TextStyle(
                        color: Color(0xFF8189B0),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Color(0xFF091B35),
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 47,
                  height: 47,
                  child: Image.asset('assets/icons/notification.png'),
                ),
              ],
            ),
            Image.asset('assets/images/strike.png'),
            Image.asset('assets/images/calendar.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.bed, color: Colors.orange[800]),
                            InkWell(
                              onTap: () async {
                                // time picker
                                final time = await showTimePicker(
                                  initialTime: timeForShowerBeforeBed,
                                  context: context,
                                );
                                if (time != null) {
                                  setState(() {});
                                  timeForShowerBeforeBed = time;
                                }
                              },
                              child: const Icon(Icons.more_vert_rounded,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const Text(
                          'Before Bed',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          '${(timeForShowerBeforeBed.hour - day.hour + 24) % 24 - 1 < 10 ? 0 : ''}${(timeForShowerBeforeBed.hour - day.hour + 24) % 24 - 1} : ${(timeForShowerBeforeBed.minute - day.minute + 60) % 60 < 10 ? 0 : ''}${(timeForShowerBeforeBed.minute - day.minute + 60) % 60}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        Switch(
                            value: isEnabledNotificationBeforeBed,
                            onChanged: (value) {
                              setState(() {
                                isEnabledNotificationBeforeBed = value;
                              });
                            },
                            activeColor: Colors.orange[800]),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.alarm, color: Colors.orange[800]),
                            InkWell(
                              onTap: () async {
                                // time picker
                                final time = await showTimePicker(
                                  initialTime: timeForShowerAfterWakeUp,
                                  context: context,
                                );
                                if (time != null) {
                                  setState(() {});
                                  timeForShowerAfterWakeUp = time;
                                }
                              },
                              child: const Icon(Icons.more_vert_rounded,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const Text(
                          'After Wake Up',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          '${(timeForShowerAfterWakeUp.hour - day.hour + 24) % 24 - 1 < 10 ? 0 : ''}${(timeForShowerAfterWakeUp.hour - day.hour + 24) % 24 - 1} : ${(timeForShowerAfterWakeUp.minute - day.minute + 60) % 60 < 10 ? 0 : ''}${(timeForShowerAfterWakeUp.minute - day.minute + 60) % 60}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        Switch(
                            value: isEnabledNotificationAfterWakeUp,
                            onChanged: (value) {
                              setState(() {
                                isEnabledNotificationAfterWakeUp = value;
                              });
                            },
                            activeColor: Colors.orange[800]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 320,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.orange[800]!.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Need to recover?',
                      style: TextStyle(
                        color: Color(0xFF8189B0),
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const Text(
                      'Go to shower!',
                      style: TextStyle(
                        color: Color(0xFF091B35),
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/timer');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.orange[800]!),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                      ),
                      child: const Text(
                        'Start session',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
