import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var path = '';

  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Wybierz plik bazy danych',
        type: FileType.custom,
        allowedExtensions: ['db']);

    // if(result == null) return;

    PlatformFile? file = result?.files.single;
    if (kDebugMode) {
      print(file?.path);
    }
    return file?.path;
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
                  onPressed: () {
                    path = _pickFile().toString();
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
