import 'package:clock_alarm_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();
    late final formatedTime = DateFormat('HH:mm').format(dt);
    late final formatedDate = DateFormat('EEE, d MMM').format(dt);
    late final timezoneString = dt.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuButton('Clock', 'assets/clock_icon.png'),
              buildMenuButton('Alarm', 'assets/alarm_icon.png'),
              buildMenuButton('Time', 'assets/timer_icon.png'),
              buildMenuButton('StopWatch', 'assets/stopwatch_icon.png'),
            ],
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(
                  0xFF2D2F41,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        'Clock',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatedTime,
                            style: const TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontSize: 64,
                            ),
                          ),
                          Text(
                            formatedDate,
                            style: const TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: ClockView(
                          size: 200,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'TimeZone',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                              Text(
                                'UTC $offsetSign $timezoneString',
                                style: const TextStyle(
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildMenuButton(String title, String image) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
        backgroundColor: (title == 'Clock') ? Colors.red : Colors.transparent,
      ),
      onPressed: () {},
      child: Column(
        children: [
          Image.asset(
            image,
            scale: 1.5,
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
