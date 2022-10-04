import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BundleCalculator extends StatefulWidget {
  const BundleCalculator({Key? key}) : super(key: key);

  @override
  State<BundleCalculator> createState() => _BundleCalculatorState();
}

var result = '';

class _GroupControllers {
  TextEditingController dim = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController resultController = TextEditingController();

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
  String _textString = ' ';

  @override
  void dispose() {
    for (final controller in _groupControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        Text(
          'Sekcja liczenia przekroju wiązki',
          style: TextStyle(fontFamily: 'MonteSerrat', fontSize: 24.0),
        ),
        Wrap(children: <Widget>[
          Container(child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _addTitle(),
            ),
          ),),


          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
              child: Center(child: _listView()),
            ),
          ),
          Container(child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _calculateAll(),
            ),
          ),),
          _addResult(result),
        ]),
      ]);

  Widget _addTitle() {
    return FilledButton(
        child: Text('Dodaj przekroje'),
        onPressed: () {
          final group = _GroupControllers();

          final dimField = _generateTextBox(group.dim, "Przekrój");
          final countField = _generateTextBox(group.count, "Ilość przewodów");

          setState(() {
            _groupControllers.add(group);
            _dimFields.add(dimField);
            _countFields.add(countField);
          });
        });
  }

  Widget _addResult(result) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(2),
      child: Center(
        child: Text(
          'Przekrój wiązki: $_textString mm2',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  //todo delete fields functionality

  TextBox _generateTextBox(TextEditingController controller, String hint) {
    return TextBox(
      controller: controller,
      header: hint,
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

  double calculateCross() {
    double finalResult = 0;
    final group = _GroupControllers();
    for (var i = 0; i < _groupControllers.length; i++) {
      double countWires = double.parse(_groupControllers[i].count.text);
      double dimWire = double.parse(_groupControllers[i].dim.text);
      var sumOfWires = dimWire * countWires;
      finalResult = finalResult + sumOfWires;
    }

    var showResult = group.resultController.text;
    print(finalResult);
    setState(() {
      _textString = finalResult.toString();
    });
    return finalResult;
  }

  Widget _calculateAll() {
    return FilledButton(
      // child: const Text('Oblicz'),
      onPressed: () async {
        String abc = calculateCross().toString();
        print(abc);
        _addResult(abc);
      },
      child: const Text("OBLICZ"),
    );
  }
}
