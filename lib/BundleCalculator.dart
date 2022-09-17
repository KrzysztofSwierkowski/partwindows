import 'package:fluent_ui/fluent_ui.dart';

class BundleCalculator extends StatefulWidget {
  const BundleCalculator({Key? key}) : super(key: key);

  @override
  State<BundleCalculator> createState() => _BundleCalculatorState();
}

class _BundleCalculatorState extends State<BundleCalculator> {
  final calculateBox = TextEditingController();
  List<TextEditingController> _dimControllers = [];
  List<TextBox> _dimFields = [];
  List<TextEditingController> _countControllers = [];
  List<TextBox> _countFields = [];
  final dim = _dimControllers[1].text;
  final count = _countControllers[1].text;


  init() {}

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        Text(
          'Sekcja liczenia przekroju wiązki',
          style: TextStyle(fontFamily: 'MonteSerrat', fontSize: 16.0),
        ),
        Wrap(children: <Widget>[
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Text('Wpisz Przekrój'),
                ),
                Flexible(
                  child: Text('Wpisz liczbę przewodów'),
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: TextBox(
                    controller: calculateBox,
                    placeholder: 'przekrój',
                  ),
                ),
                Flexible(
                  child: TextBox(
                    controller: calculateBox,
                    placeholder: 'Liczba przewodów',
                  ),
                ),
              ]),
        ]),
    Padding(padding: EdgeInsets.all(16.0)),
    FilledButton(
      child: Text('Dodaj przekroje'),
      onPressed: () {
        print('pressed filled button');
      },
    ),
      ]);
}
