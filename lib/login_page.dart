import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                  child: Column(
                    children: const [
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottleService()));
                  },
                  child: const Text('Nav to Bottle Service'))
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

  // Container(
  //             decoration: BoxDecoration(
  //               border: Border(
  //                 top: BorderSide(
  //                   color: Colors.grey[400]!,
  //                   width: 1.5,
  //                 ),
  //               ),
  //             ),
  //             height: 60,
  //             child: Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text('Total', style: textStyleSubHeading),
  //                           Text('\$1404.99', style: textStyleSubHeadingGrey),
  //                         ],
  //                       ),
  //                       ElevatedButton(
  //                           onPressed: () {},
  //                           child: const Text(
  //                             'Purchase',
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w500),
  //                           ))
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
          

// Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: DropdownButton(
//                             focusColor: const Color.fromARGB(255, 41, 41, 41),
//                             dropdownColor: Colors.grey[900],
//                             borderRadius: BorderRadius.circular(5),
//                             isExpanded: true,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400),
//                             value: 1,
//                             alignment: Alignment.center,
//                             items: const [
//                               DropdownMenuItem(
//                                 value: 1,
//                                 child: Text('Table 1'),
//                               ),
//                               DropdownMenuItem(
//                                 value: 2,
//                                 child: Text('Table 2'),
//                               ),
//                               DropdownMenuItem(
//                                 value: 3,
//                                 child: Text('Table 3'),
//                               ),
//                             ],
//                             onChanged: (value) {},
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),