import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'PartModel.dart';

class PartDB extends StatefulWidget {
  const PartDB({Key? key}) : super(key: key);

  @override
  State<PartDB> createState() => _PartDBState();
}

class _PartDBState extends State<PartDB> {
  final dbHelper = DatabaseHelper.instance;

  init() {}

  List<Part> part = [];
  List<Part> partByName = [];

  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController numberUpdateController = TextEditingController();
  TextEditingController typeUpdateController = TextEditingController();

  TextEditingController idDeleteController = TextEditingController();
  TextEditingController queryController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Dodaj',
              ),
              Tab(
                text: 'Wyświetl Wszystko',
              ),
              Tab(
                text: 'Wyszukaj',
              ),
              Tab(
                text: 'Zmień',
              ),
              Tab(
                text: 'Usuń',
              ),
            ],
          ),
          title: const Text('PartBase'),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: typeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type Part',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name Part',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: numberController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name Part',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Dodaj część do bazy danych'),
                    onPressed: () {
                      String name = nameController.text;
                      String type = typeController.text;
                      String number = numberController.text;
                      _insert(name, type, number); //todo add method
                    },
                  )
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: part.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == part.length) {
                  return ElevatedButton(
                    child: const Text('Odśwież'),
                    onPressed: () {
                      setState(() {
                        _queryAll();
                      });
                    },
                  );
                }
                return SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                        'Id: ${part[index].id} | Numer: ${part[index].number}] | Nazwa: ${part[index].name} | Typ: ${part[index].type}',
                        style: const TextStyle(fontSize: 18)),
                  ),
                );
              },
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 100,
                    child: TextField(
                      controller: queryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Name',
                      ),
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          setState(() {
                            _query(text);
                          });
                        } else {
                          setState(() {
                            partByName.clear();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: partByName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          margin: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              'ID: ${partByName[index].id}  | Nazwa: ${partByName[index].name}  | Numer: ${partByName[index].number}  | Typ: ${partByName[index].type} ',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part ID',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameUpdateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: numberUpdateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Number',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: typeUpdateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Type',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int id = int.parse(idUpdateController.text);
                      String name = nameUpdateController.text;
                      String number = numberUpdateController.text;
                      String type = typeUpdateController.text;
                      _update(id, name, number, type);
                    },
                    child: const Text('Update Part'),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: idDeleteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part id',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int id = int.parse(idDeleteController.text);
                      _delete(id);
                    },
                    child: const Text('Delete Part'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insert(name, type, number) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnType: type,
      DatabaseHelper.columnNumber: number
    };

    Part part = Part.fromMap(row);
    final id = await dbHelper.insert(part);
    _showMessageInScaffold('Część $id została dodana');
  }

  _delete(id) async {
    final rowsDeleted = await dbHelper.delete(id);
    _showMessageInScaffold('Usunięto  $rowsDeleted rekord/y: row $id');
  }

  _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    part.clear();
    for (var row in allRows) {
      part.add(Part.fromMap(row));
    }
    _showMessageInScaffold('Gotowe !');
    setState(() {});
  }

  _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    partByName.clear();
    for (var row in allRows) {
      partByName.add(Part.fromMap(row));
    }
  }

  _update(id, type, number, name) async {
    Part part = Part(id, type, number, name);
    final rowsAffected = await dbHelper.update(part);
    _showMessageInScaffold('Część $rowsAffected została zaktualizowana');
  }
}
