import 'package:flutter/material.dart';
import 'package:project_week8/screens/editprofile.dart';
import 'package:project_week8/screens/home.dart';
import 'package:project_week8/screens/login.dart';
import 'package:project_week8/screens/privacy.dart';
import 'package:project_week8/screens/sellproduct.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsOverlayScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
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
                        builder: (context) =>const ScreenHome(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage(
                  'assets/images/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Melvin Cherian',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
                child: const Text('Edit Profile'),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 90),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SellProduct()));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.shop, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Sell products',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                ),
               
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 90),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenPrivacy(),
                      ),
                    );
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
                  ),
                )
              ],
            ),
            const SizedBox(height: 100),
            // Row(
            //   children: [
            //     const SizedBox(width: 170),
            //     TextButton(
            //       onPressed: () {
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               title: const Text('Are you sure?'),
            //               content: const Text('Do you want to log out?'),
            //               actions: <Widget>[
            //                 TextButton(
            //                   onPressed: () {
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: const Text('Cancel'),
            //                 ),
            //                 TextButton(
            //                   onPressed: () {
            //                     ScaffoldMessenger.of(context).showSnackBar(
            //                       const SnackBar(
            //                         content: Text('Logged out successfully!'),
            //                         backgroundColor: Colors.green,
            //                       ),
            //                     );

            //                     Navigator.of(context).pushAndRemoveUntil(
            //                       MaterialPageRoute(
            //                         builder: (context) => const ScreenLogin(),
            //                       ),
            //                       (route) => false,
            //                     );
            //                   },
            //                   child: const Text('Log Out',
            //                       style: TextStyle(fontSize: 20)),
            //                 ),
            //               ],
            //             );
            //           },
            //         );
            //       },
            //       child: const Text('Log Out', style: TextStyle(fontSize: 20)),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SettingsOverlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Padding(
          padding:const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _showLogoutConfirmation(context);
                },
                icon:const Icon(Icons.logout),
                label:const Text('Log out'),
              ),
         const     SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Terms of Service screen
                },
                icon:const Icon(Icons.policy),
                label:const Text('Terms of Service'),
              ),
          const    SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to About screen
                },
                icon:const Icon(Icons.info),
                label:const Text('About'),
              ),
           const   SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement share functionality
                },
                icon:const Icon(Icons.share),
                label:const Text('Share App'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Are you sure?'),
          content:const Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
              const    SnackBar(
                    content: Text('Logged out successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>const ScreenLogin(),
                  ),
                  (route) => false,
                );
              },
              child:const Text('Log Out', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }
}
