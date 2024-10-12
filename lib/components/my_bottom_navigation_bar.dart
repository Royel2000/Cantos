// my_drawer.dart
import 'package:flutter/material.dart';

class MyBootomNavigationBar extends StatefulWidget {
  const MyBootomNavigationBar({super.key});

  @override
  State<MyBootomNavigationBar> createState() => _MyBootomNavigationBarState();
}

class _MyBootomNavigationBarState extends State<MyBootomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 20.0, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/main');  
            },
            icon: const Icon(
              Icons.home_filled,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.menu_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
