import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zen/themes/theme_provider.dart';
import 'package:zen/themes/themes_enum.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: AppThemes.values.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: RadioListTile<String>(
              title: Text(AppThemes.values[index].name),
              value: AppThemes.values[index].name,
              groupValue: selectedValue,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedValue = value;
                  });
                  ThemeProvider themeProvider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.setTheme(AppThemes.findByName(value));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
