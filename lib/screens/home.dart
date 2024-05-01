import 'package:flutter/material.dart';
import 'package:project_week8/screens/categories.dart';
import 'package:project_week8/screens/favourites.dart';
import 'package:project_week8/screens/login.dart';
import 'package:project_week8/screens/profile.dart';
import 'package:project_week8/screens/proupdates.dart';
import 'package:project_week8/screens/selldetails.dart';
import 'package:project_week8/screens/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyCategories()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenProfile()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFavourite()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 38,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _onItemTapped(0);
              },
              icon: Icon(
                Icons.home,
                size: 30,
                color: _selectedIndex == 0 ? Colors.blue : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                _onItemTapped(1);
              },
              icon: Icon(
                Icons.add_box,
                size: 30,
                color: _selectedIndex == 1 ? Colors.blue : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                _onItemTapped(2);
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: _selectedIndex == 2 ? Colors.blue : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                _onItemTapped(3);
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: _selectedIndex == 3 ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Stock()),
                        );
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScreenUpdate()));
                      },
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellDetails()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(8),
            //       child: Container(
            //         height: 150,
            //         width: 180,
            //         color: const Color.fromARGB(255, 237, 218, 192),
            //         child: GestureDetector(
            //           child: const Padding(
            //             padding: EdgeInsets.all(40),
            //             child: Text(
            //               'Return\nDetails',
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const ScreenReturn()),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ]
            // )
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
      (route) => false,
    );
  }
}
