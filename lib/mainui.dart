import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'PartModel.dart';

class mainui extends StatefulWidget {
  const mainui({Key? key}) : super(key: key);

  @override
  State<mainui> createState() => _mainuiState();
}

class _mainuiState extends State<mainui> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
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
          bottom: TabBar(
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
          title: Text('PartBase'),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type Part',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name Part',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name Part',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Insert Part to the base'),
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
            Container(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: part.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == part.length) {
                    return ElevatedButton(
                      child: Text('Odśwież'),
                      onPressed: () {
                        setState(() {
                          _queryAll();
                        });
                      },
                    );
                  }
                  return Container(
                    height: 40,
                    child: Center(
                      child: Text(
                          'Id: ${part[index].id} | Numer: ${part[index].number}] | Nazwa: ${part[index].name} | Typ: ${part[index].type}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 100,
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Name',
                      ),
                      onChanged: (text) {
                        if (text.length >= 1) {
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
                  Container(
                    height: 300,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: partByName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              'ID: ${partByName[index].id}  | Nazwa: ${partByName[index].name}  | Numer: ${partByName[index].number}  | Typ: ${partByName[index].type} ',
                              style: TextStyle(fontSize: 18),
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
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part ID',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: numberUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Part Number',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: typeUpdateController,
                      decoration: InputDecoration(
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
                    child: Text('Update Part'),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idDeleteController,
                      decoration: InputDecoration(
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
                    child: Text('Delete Part'),
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
    allRows.forEach((row) => part.add(Part.fromMap(row)));
    _showMessageInScaffold('Gotowe !');
    setState(() {});
  }

  _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    partByName.clear();
    allRows.forEach((row) => partByName.add(Part.fromMap(row)));
  }

  _update(id, type, number, name) async {
    Part part = Part(id, type, number, name);
    final rowsAffected = await dbHelper.update(part);
    _showMessageInScaffold('Część $rowsAffected została zaktualizowana');
  }
}
