import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/MainNav.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  // Init ffi loader if needed.
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  String path = "Part.db";
  var db = await databaseFactory.openDatabase(path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      home: MainNav(),
      title: 'PartBase',
    );
  }
}
