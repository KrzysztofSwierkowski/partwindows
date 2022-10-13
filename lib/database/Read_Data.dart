import 'dart:core';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/database/DBHelper.dart';
import 'package:partwindows/database/PartModel.dart';

final dbHelper = DatabaseHelper.instance;
List<Part> part = [];

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  ReadDataState createState() => ReadDataState();
}

class ReadDataState extends State<ReadData> {
  _readAll() async {
    final allRows = await dbHelper.queryAllRows();
    part.clear();
    for (var row in allRows) {
      part.add(Part.fromMap(row));
    }
    var partlist = part.toList();
    setState(() {});
    return partlist;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Table(
                border: TableBorder.all(width: 1, color: Colors.black),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: const [
                        Text('NAME', textAlign: TextAlign.center),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: const [
                        Text('NUMBER', textAlign: TextAlign.center),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: const [
                        Text('TYPE', textAlign: TextAlign.center),
                      ]),
                    ),
                  ]),
                ]),
            Table(
              border: TableBorder.all(width: 1, color: Colors.black),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                // 3: IntrinsicColumnWidth(),
              },
              children: List<TableRow>.generate(
                part.length,
                (index) {
                  final partB = part[index];

                  return TableRow(children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: Text(partB.id.toString(),
                    //       textAlign: TextAlign.center),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(partB.name, textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(partB.number, textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(partB.type, textAlign: TextAlign.center),
                    ),
                  ]);
                },
                growable: false,
              ),
            ),
            FilledButton(
              child: const Text('Pobierz Dane'),
              onPressed: () {
                setState(() {
                  _readAll();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
