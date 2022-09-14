import 'package:fluent_ui/fluent_ui.dart';

class BundleCalculator extends StatefulWidget {
  const BundleCalculator({Key? key}) : super(key: key);

  @override
  State<BundleCalculator> createState() => _BundleCalculatorState();
}

class _BundleCalculatorState extends State<BundleCalculator> {

  final calculateBox = TextEditingController();


  init(){


  }

  @override
  Widget build(BuildContext context) =>  Center(child: Column(
      children: <Widget>[
  Container(
    padding: EdgeInsets.all(20),
    child: TextBox(
      controller: calculateBox,
      header: 'podaj liczbę żył',
      placeholder: 'liczba żył',
      ),
    ),

  ]
  ));


}