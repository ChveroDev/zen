import 'package:flutter/material.dart';
import 'package:zen/data/task_dao.dart';
import 'package:zen/data/task_database.dart';
import 'package:zen/view/calendar_page/calendar_page.dart';
import 'package:zen/view/settings_page/settings_page.dart';
import 'package:zen/view/task_list_page/task_list_page.dart';
import 'package:zen/view/tree_visualizer_page/tree_structure.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  bool showAddMenu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ZEN"),
        centerTitle: true,
        primary: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: currentPageIndex == 0
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                  selectedIcon: const Icon(Icons.home),
                  icon: const Icon(Icons.home_outlined),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 0;
                    });
                  },
                  isSelected: currentPageIndex == 0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: currentPageIndex == 1
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                  selectedIcon: Icon(Icons.account_tree),
                  icon: Icon(Icons.account_tree_outlined),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 1;
                    });
                  },
                  isSelected: currentPageIndex == 1,
                ),
              ),
              SizedBox(),
              Container(
                decoration: BoxDecoration(
                    color: currentPageIndex == 2
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                  selectedIcon: Icon(Icons.calendar_month),
                  icon: Icon(Icons.calendar_month_outlined),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 2;
                    });
                  },
                  isSelected: currentPageIndex == 2,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: currentPageIndex == 3
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 3;
                    });
                  },
                  isSelected: currentPageIndex == 3,
                ),
              ),
            ],
          ),
        ),
      ),
      body: <Widget>[
        const TaskListPage(),
        TreeStructure(),
        const CalendarPage(),
        SettingsPage()
      ][currentPageIndex],
    );
  }

  _addTask() {}
}
