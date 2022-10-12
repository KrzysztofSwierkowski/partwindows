import 'dart:io';

import 'package:file_picker/file_picker.dart';



class NewDatabase {

  final file = File('clean.db');
saveDatabase() async {
  String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: 'Wybierz miejsce zapisu nowej bazy danych',
    fileName: 'part.db',
  );

  if (outputFile == null) {
    // User canceled the picker
  }
}



}