import 'package:flutter/material.dart';
import 'package:project_week8/main.dart';
import 'package:project_week8/screens/home.dart';
import 'package:project_week8/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkSharedpreference();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image:
              AssetImage('assets/images/b238018c0a4861898f3f44f78ce3eb2c.jpg'),
          height: 300,
          width: 400,
        ),
        
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScreenLogin()));
  }

  Future<void> checkSharedpreference() async {
    final sharedpref = await SharedPreferences.getInstance();

    final userLogged = sharedpref.getBool(SAVE_KEY_NAME);
    if (userLogged == null || userLogged == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
  }
}
