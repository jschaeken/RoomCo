import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:roomco/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //animatio reload on hot restart
    Animate.restartOnHotReload = true;
    //login page
    return Container(
      //gradient background
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.amber])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'RoomCo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Connecting roommates',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(),
              const SizedBox(
                height: 250,
              ),
              //login button
              LoginPageButton(
                text: 'Login',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                                title: 'RoomCo',
                                roomNumber: '504',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //register button
              LoginPageButton(
                text: 'Register',
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottleService()));
                    },
                    child: const Text('Nav to Bottle Service')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QrDemoFomo()));
                    },
                    child: const Text('Nav to _QrDemoFomoState')),
              )
            ],
          )),
    );
  }
}

class LoginPageButton extends StatelessWidget {
  const LoginPageButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class BottleService extends StatefulWidget {
  const BottleService({super.key});

  @override
  State<BottleService> createState() => _BottleServiceState();
}

class _BottleServiceState extends State<BottleService> {
  double value = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Text('Bottle Service', style: textStyleHeading),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        CupertinoIcons.share,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Throwback Dance Party', style: textStyleHeading),
                  Text('by Papi Calgary', style: textStyleSubHeading),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Choose a table', style: textStyleHeading),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.slider_horizontal_3,
                          color: Colors.white),
                      Text('Price range', style: textStyleSubHeading),
                      const Spacer(),
                      Text(
                        '100',
                        style: textStyleSubHeading,
                      ),
                      Slider(
                        value: value.clamp(100, 2000),
                        min: 100,
                        max: 2000,
                        inactiveColor: Colors.white,
                        activeColor: const Color.fromARGB(255, 158, 12, 68),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      //Text '2000'
                      Text('2000', style: textStyleSubHeading),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Table information', style: textStyleHeading),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('- 4 bottles of Grey Goose', style: textStyleSubHeading),
                  Text('- Seats 6 people', style: textStyleSubHeading),
                  Text('- Automatic gratuity of 18% included',
                      style: textStyleSubHeading),
                  Text('- Non-refundable purchase', style: textStyleSubHeading),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Note from the event organizer about this purchase',
                      style: textStyleHeading),
                  Text(
                      'Please arrive at the dor no later than 2 hours after the event start time for smooth service',
                      style: textStyleSubHeading),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text('Purchase Summary', style: textStyleHeading),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Table 1', style: textStyleSubHeading),
                    ],
                  ),
                  makeItemRows('Subtotal', '\$1095'),
                  makeItemRows('18% gratuity', '\$197.10'),
                  makeItemRows('Processing fee', '\$116.29'),
                  makeItemRows('Tax', '\$64.61'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final textStyleSubHeading = const TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300);

  final textStyleSubHeadingGrey = const TextStyle(
      color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w300);
  final textStyleHeading = const TextStyle(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

  makeItemRows(String text, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: textStyleSubHeading),
        Text(price, style: textStyleSubHeadingGrey),
      ],
    );
  }
}

class QrDemoFomo extends StatefulWidget {
  const QrDemoFomo({super.key});

  @override
  State<QrDemoFomo> createState() => _QrDemoFomoState();
}

class _QrDemoFomoState extends State<QrDemoFomo> {
  //making the widget rebuild every 1 second

  String currentData = "TICKET_COWBOYS_XYZ_123";
  String currentHash = "";
  String currentTimeString = "";
  final String deviceID = "1234567890";
  final String salt = 'FOMO_SALT_PHRASE';

  String hashData(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTimeString = DateTime.now().millisecondsSinceEpoch.toString();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        //millisecondssinceepoch
        currentTimeString = DateTime.now().millisecondsSinceEpoch.toString();
        currentHash =
            hashData(currentData + currentTimeString + deviceID + salt);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload;
    print('rebuilding');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              const Text(
                'Fomo QR Code Demo',
                style: TextStyle(
                    color: Color.fromARGB(255, 216, 21, 99),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ticket Data:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          currentData,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Device ID:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          deviceID,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Salt:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          salt,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Current Time:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          child: StatefulBuilder(builder: (context, refresh) {
                            var localTimeString =
                                '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
                            //make this update every 10 milliseconds
                            Timer.periodic(const Duration(milliseconds: 10),
                                (timer) {
                              refresh(() {
                                localTimeString =
                                    '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().millisecond}';
                              });
                            });
                            return Text(
                              localTimeString,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            );
                          }),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Time Epoch Snapshot for Hash:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            currentTimeString,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    //spacing
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Current Hash:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            currentHash,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedBorderContainer(
                child: QrImage(
                  data: currentHash,
                  version: QrVersions.auto,
                  size: 240.0,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: Color.fromARGB(255, 216, 21, 99),
                  ),
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: Color.fromARGB(255, 216, 21, 99),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//a widget that is a onlined container with a gradient border, and the border gradient is constantly changing

class AnimatedBorderContainer extends StatefulWidget {
  const AnimatedBorderContainer({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  _AnimatedBorderContainerState createState() =>
      _AnimatedBorderContainerState();
}

class _AnimatedBorderContainerState extends State<AnimatedBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: SweepGradient(
                //like a clock, start at 12 o'clock with the animation value
                startAngle: controller.value * 2 * pi,
                //and end at 12 o'clock
                endAngle: controller.value * 2 * pi + pi,
                tileMode: TileMode.mirror,
                colors: const [
                  //smoothly transition between these colors
                  // Color.lerp(const Color.fromARGB(255, 216, 21, 99),
                  //     const Color.fromARGB(255, 32, 32, 32), controller.value)!,
                  // const Color.fromARGB(255, 32, 32, 32),
                  // const Color.fromARGB(255, 32, 32, 32),
                  // Color.lerp(
                  //     const Color.fromARGB(255, 32, 32, 32),
                  //     const Color.fromARGB(255, 216, 21, 99),
                  //     controller.value)!,
                  Color.fromARGB(255, 32, 32, 32),
                  Color.fromARGB(255, 32, 32, 32),
                  Color.fromARGB(255, 32, 32, 32),
                  Color.fromARGB(255, 32, 32, 32),
                  Color.fromARGB(255, 216, 21, 99),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 32, 32),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
