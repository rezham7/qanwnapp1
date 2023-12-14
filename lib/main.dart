import 'package:flutter/material.dart';
import 'package:qanwnapp/favorite_page.dart';
import 'package:qanwnapp/home_page.dart';
import 'package:qanwnapp/lawyers.dart';
import 'package:qanwnapp/menu_page.dart';
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

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> pages = [const HomePage(), const Lawyer(), menuPage()];

  int _index = 0;

  selectIndex(int pageindex) {
    setState(() {
      _index = pageindex;
    });
  }

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
              label: 'یاساکان',
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/attorney.png',
                  height: 30,
                  color: const Color(0xffEABF4E),
                ),
                label: 'weee')
          ],
          onTap: selectIndex,
          backgroundColor: const Color.fromARGB(255, 3, 73, 131),
          selectedItemColor: Colors.amber,
          currentIndex: _index,
        ),
      ),
    );
  }
}
