import 'package:flutter/material.dart';
import 'package:project_week8/screens/home_screen.dart';
// import 'package:fl_chart/fl_chart.dart';

class ScreenProfit extends StatefulWidget {
  const ScreenProfit({super.key});
  
  @override
  State<ScreenProfit> createState() => _ScreenProfitState();
}

class _ScreenProfitState extends State<ScreenProfit> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 17),
            const SizedBox(width: 19),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenHome()));
                    },
                    color: Colors.black,
                  ),
                  const SizedBox(width: 60),
                  const Text(
                    'Profit Details',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
       