import 'package:flutter/material.dart';
import 'package:project_week8/main.dart';
import 'package:project_week8/screens/Home_Screen.dart';
import 'package:project_week8/screens/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
    checkSharedpreference();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B4DB), Color.fromARGB(255, 214, 239, 202)], // Example gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: _animation.value,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/b238018c0a4861898f3f44f78ce3eb2c.jpg',
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover, // Ensure the image fits within the circle
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Opacity(
                opacity: _animation.value,
                child: const Text(
                  'BOOKHUB',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto', // Change to your preferred font
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ScreenLogin()));
  }

  Future<void> checkSharedpreference() async {
    final sharedpref = await SharedPreferences.getInstance();

    final userLogged = sharedpref.getBool(SAVE_KEY_NAME);
    if (userLogged == null || userLogged == false) {
      gotoLogin();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
  }
}
