import 'package:flutter/material.dart';
import 'package:qanwnapp1/court.dart';
import 'package:qanwnapp1/home_page.dart';
import 'package:qanwnapp1/lawyers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//eertertdy
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(204, 201, 10, 26)),
        useMaterial3: true,
      ),
      home: BottomNavigation(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> pages = [const HomePage(), const Lawyer(), const court()];

  int _index = 0;

  selectIndex(int pageindex) {
    setState(() {
      _index = pageindex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/rule.png',
                    height: 30, color: const Color(0xffEABF4E)),
                label: 'یاساکان'),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/attorney.png',
                height: 30,
                color: const Color(0xffEABF4E),
              ),
              label: 'پارێزەران',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/attorney.png',
                height: 30,
                color: const Color(0xffEABF4E),
              ),
              label: 'پارێزەران',
            ),
            
            
          ],
          onTap: selectIndex,
          backgroundColor: const Color.fromARGB(255, 7, 15, 24),
          selectedItemColor: Colors.amber,
          currentIndex: _index,
        ),
      ),
    );
  }
}
