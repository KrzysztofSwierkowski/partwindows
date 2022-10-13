import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/database/DBHelper.dart';
import 'package:partwindows/database/PartModel.dart';


class SearchPart extends StatefulWidget {
  const SearchPart({Key? key}) : super(key: key);

  @override
  State<SearchPart> createState() => _SearchPartState();
}

class _SearchPartState extends State<SearchPart> {
  final dbHelper = DatabaseHelper.instance;

  init() {}

  List<Part> part = [];
  List<Part> partByName = [];

  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: TextBox(
              controller: queryController,
              header: 'Nazwa',
              placeholder: 'Nazwa Części',
              expands: false,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
              child: const Text('Pobierz Dane'),
              onPressed: () {
                setState(() {
                  _query(queryController.text);
                });
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
                      'Nazwa: ${partByName[index].name}  | Numer: ${partByName[index].number}  | Typ: ${partByName[index].type} ',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _query(name) async {
    final allRows = await dbHelper.queryRows(name);
    partByName.clear();
    for (var row in allRows) {
      partByName.add(Part.fromMap(row));
    }
  }
}
