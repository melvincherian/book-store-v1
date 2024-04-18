import 'package:flutter/material.dart';
import 'package:project_week8/screens/editprofile.dart';
import 'package:project_week8/screens/home.dart';
import 'package:project_week8/screens/newcategory.dart';
import 'package:project_week8/screens/privacy.dart';
import 'package:project_week8/screens/signup.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 237, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 16),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenHome()));
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage(
                  'assets/360_F_511314471_DNmKOdRIS3mp5pgg4OfIW2NtLNSBrieN.jpg'),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Melvin Cherian',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) =>  EditProfile()));
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 50),
                TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.shop, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Sell products',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      ],
                    )),
                const Row(
                  children: [
                    SizedBox(width: 130),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenPrivacy()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewCategory()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.qr_code_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Add New Categories',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                const SizedBox(width: 170),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Do you want to log out?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Logged out successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenLogout()),
                                    (route) => false);
                                    
                              },
                              child: const Text('Log Out'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Log Out'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
}
