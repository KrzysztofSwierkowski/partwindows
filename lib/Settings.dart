import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
var path2 ;

  Future<String?> _pickFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Wybierz plik bazy danych',
        type: FileType.custom,
        allowedExtensions: ['db']);

     if(result == null) return null;

    PlatformFile? file = result.files.single;


    return path2 = file?.path;
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Align(
              child: Container(
                alignment: Alignment.topLeft,
                child: FilledButton(
                  child: const Text('Lokalizacja bazy danych'),
                  onPressed: () async {
                    path2 = _pickFile().toString();
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('path2',path2);

                  },
                ),
              ),
            ),
          ),
        ),
      );
}
