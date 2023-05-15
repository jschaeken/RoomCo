import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const darkMode = true;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: darkMode
                  ? RadialGradient(
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Color.fromARGB(255, 0, 123, 255),
                        Color.fromARGB(255, 0, 123, 255),
                      ],
                      radius: 2.9,
                      stops: [0.06, .5, 1],
                      center: Alignment(0.0, -.42),
                    )
                  // ignore: dead_code
                  : RadialGradient(
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 0, 123, 255),
                        Color.fromARGB(255, 0, 123, 255),
                      ],
                      radius: 2,
                      stops: [0.0, .6, 1],
                      center: Alignment(0.0, -.42),
                    )),
        ),

        //SingleSki
        Padding(
          padding: const EdgeInsets.only(top: 54),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .93,
              width: MediaQuery.of(context).size.width * .4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter,
                  colors: darkMode
                      ? [
                          Color.fromARGB(255, 0, 123, 255),
                          Color.fromARGB(178, 0, 123, 255),
                          Color.fromARGB(23, 0, 123, 255),
                          Color.fromARGB(0, 0, 123, 255),
                        ]
                      // ignore: dead_code
                      : [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(177, 255, 255, 255),
                          Color.fromARGB(22, 255, 255, 255),
                          Color.fromARGB(0, 255, 255, 255),
                        ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200)),
              ),
            ),
          ).animate().moveY(
              duration: 2000.ms,
              begin: 1000,
              curve: Curves.fastLinearToSlowEaseIn),
        ),
      ],
    );
  }
}
