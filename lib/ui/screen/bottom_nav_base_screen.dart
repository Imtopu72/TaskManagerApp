import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskmanager/ui/screen/cancelled_task_screen.dart';
import 'package:taskmanager/ui/screen/completed_task_screen.dart';
import 'package:taskmanager/ui/screen/in_progress_task_screen.dart';
import 'package:taskmanager/ui/screen/new_task_screen.dart';


class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        selectedItemColor: Colors.deepOrange,
        onTap: (int index){
          _selectedScreenIndex = index;
          if(mounted){
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.tasks),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.barsProgress),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.rectangleXmark),
            label: 'Cancelled',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.rectangleList),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}