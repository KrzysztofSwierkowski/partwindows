import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:partwindows/database/NewDatabase.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String path2 = "";
  NewDatabase _database = NewDatabase();

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Wybierz plik bazy danych',
        type: FileType.custom,
        allowedExtensions: ['db']);

    if (result == null) return null;

    String path2 = result.files.single.path!;

    return path2;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: FilledButton(
                      child: const Text('Lokalizacja bazy danych'),
                      onPressed: () async {
                        _pickFile().then((path2) async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('path2', path2);});
                      },
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: FilledButton(
                      child: const Text('Utwórz nową bazę danych'),
                      onPressed: () async {
//todo: create method for clean db.
                      _database.saveDatabase();
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
