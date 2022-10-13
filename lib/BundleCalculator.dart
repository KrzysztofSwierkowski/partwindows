import 'package:fluent_ui/fluent_ui.dart';

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
  final List<_GroupControllers> _groupControllers = [];
  final List<TextBox> _dimFields = [];
  final List<TextBox> _countFields = [];
  String _resultBundle = '0';

  @override
  void dispose() {
    for (final controller in _groupControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        const Text(
          'Sekcja liczenia przekroju wiązki',
          style: TextStyle(fontFamily: 'MonteSerrat', fontSize: 24.0),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Wrap(children: <Widget>[
                Row(children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                      child: _addTitle(),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                      child: _deleteTitle(),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                      child: _calculateAll(),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                  child: Center(child: _listView()),
                ),
                _addResult(),
              ]),
            ]),
          ),
        ),
      ]);

  Widget _addTitle() {
    return FilledButton(
        child: const Text('Dodaj przekroje'),
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

  Widget _deleteTitle() {
    return FilledButton(
      child: const Text('Usuń przekroje'),
      onPressed: () {
        setState(() {
          _groupControllers.removeLast();
          _dimFields.removeLast();
          _countFields.removeLast();
        });
      },
    );
  }

  Widget _addResult() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(2),
      child: Center(
        child: Text(
          'Przekrój wiązki: $_resultBundle mm2',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  //todo delete fields functionality and side bar

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
          margin: const EdgeInsets.all(5),
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

    for (var i = 0; i < _groupControllers.length; i++) {
      double countWires = double.parse(_groupControllers[i].count.text);
      double dimWire = double.parse(_groupControllers[i].dim.text);
      var sumOfWires = dimWire * countWires;
      finalResult = finalResult + sumOfWires;
    }

    setState(() {
      _resultBundle = finalResult.toString();
    });
    return finalResult;
  }

  Widget _calculateAll() {
    return FilledButton(
      onPressed: () async {
        calculateCross();
      },
      child: const Text("OBLICZ"),
    );
  }
}
