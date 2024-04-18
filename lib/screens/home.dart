import 'package:flutter/material.dart';
import 'package:project_week8/screens/categories.dart';
import 'package:project_week8/screens/login.dart';
import 'package:project_week8/screens/profile.dart';
import 'package:project_week8/screens/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
              fontSize: 38, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ScreenLogin()));
              signout(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenHome()));
                },
                icon: const Icon(Icons.home)),
            label: 'Home'),
            
        BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyCategories()));
              },
              icon: const Icon(Icons.add_box),
              color: Colors.blue,
            ),
            label: 'Categories'),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScreenProfile()));
            },
            icon: const Icon(Icons.person),
            color: Colors.blue,
          ),
          label: 'Profile',
          
        ),
      ]),
      
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    width: 180,
                    color: const Color.fromARGB(255, 237, 218, 192),
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Total\nStock',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Stock()));
                      },
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    width: 180,
                    color: const Color.fromARGB(255, 200, 245, 200),
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Product\nupdates',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    width: 180,
                    color: const Color.fromARGB(255, 250, 246, 210),
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Todays\nprofit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    width: 180,
                    color: const Color.fromARGB(255, 251, 225, 225),
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Sell\ndetails',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  signout(BuildContext context) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (route) => false);
  }
}
