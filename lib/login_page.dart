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
