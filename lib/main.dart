import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zen/data/task_database.dart';
import 'package:zen/themes/app_theme.dart';
import 'package:zen/themes/cold_app_theme.dart';
import 'package:zen/themes/theme_provider.dart';
import 'package:zen/view/main_page.dart';
import 'package:zen/view/task_list_page/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await TaskDataBase.instance.database;
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(const ColdTheme()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme.getTheme(),
          home: const MainPage(),
        );
      },
    );
  }
}
