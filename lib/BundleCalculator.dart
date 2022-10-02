import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class BundleCalculator extends StatefulWidget {
  const BundleCalculator({Key? key}) : super(key: key);

  @override
  State<BundleCalculator> createState() => _BundleCalculatorState();
}

class _GroupControllers {
  TextEditingController dim = TextEditingController();
  TextEditingController count = TextEditingController();

  void dispose() {
    dim.dispose();
    count.dispose();
  }
}

class _BundleCalculatorState extends State<BundleCalculator> {
  // final calculateBox = TextEditingController();
  List<_GroupControllers> _groupControllers = [];
  List<TextBox> _dimFields = [];
  List<TextBox> _countFields = [];


  @override
  void dispose() {
    for (final controller in _groupControllers) {
      controller.dispose();
    }
    //_okController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        Text(
          'Sekcja liczenia przekroju wiązki',
          style: TextStyle(fontFamily: 'MonteSerrat', fontSize: 24.0),
        ),
        Wrap(children: <Widget>[
          _addTile(),
          _calculateAll(),
          Center(child: _listView()),
          _okButton(context),
        ]),
        Padding(padding: EdgeInsets.all(16.0)),
        // FilledButton(
        //   child: Text('Dodaj przekroje'),
        //   onPressed: () {
        //     _addTile();
        //   },
        // ),
      ]);

  Widget _addTile() {
    return FilledButton(
        child: const Text('Dodaj grupę przewodów'),
        onPressed: () {
          final group = _GroupControllers();

          final dimField = _generateTextBox(group.dim, "przekrój");
          final countField = _generateTextBox(group.count, "ilość");

          setState(() {
            _groupControllers.add(group);
            _dimFields.add(dimField);
            _countFields.add(countField);
          });
        });
  }

  TextBox _generateTextBox(TextEditingController controller, String hint) {
    return TextBox(
      controller: controller,
      // decoration: InputDecoration(
      //   border: OutlineInputBorder(),
      //   labelText: hint,
      // ),
    );
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < _groupControllers.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [_dimFields[i], _countFields[i]],
          ),
        ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  // final _okController = TextEditingController();

  Widget _okButton(BuildContext context) {
/*    final textBox = TextBox(
      controller: _okController,
      keyboardType: TextInputType.number,
    );*/
// todo: should add support for calculate the cable. Should add  loop to add all dimm
    final button = FilledButton(
      onPressed: () async {

      },
      child: Text("OK"),
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        button,
      ],
    );
  }

  TextBox calulateCross() {
    var finalResult = 0;
    for (var i = 0; i < _groupControllers.length;i++) {
      int countWires = int.parse(_groupControllers[i].count.text);
      int dimWire = int.parse(_groupControllers[i].dim.text);
      var sumOfWires = dimWire * countWires;
      finalResult = finalResult + sumOfWires;

    }
    print(finalResult);
    return TextBox(
      readOnly: true,
      placeholder: 'I am super excited to be here',
      style: TextStyle(
        fontFamily: 'Arial',
        fontSize: 24.0,
        letterSpacing: 8,
        color: Color(0xFF5178BE),
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _calculateAll() {
    return FilledButton(
       // child: const Text('Oblicz'),
        onPressed: () async {
          calulateCross();
          print(calulateCross);

        },
      child: Text("OK"),);
  }
}

