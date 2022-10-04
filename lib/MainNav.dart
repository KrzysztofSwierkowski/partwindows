import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/mainui.dart';
import 'package:partwindows/BundleCalculator.dart';
import 'read_data.dart';

class MainNav extends StatefulWidget {
  const MainNav({ Key? key }) : super(key: key);

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    //todo implement fluent_ui update (4.0.1)
    return NavigationView(
      pane: NavigationPane(
          selected: _currentPage,
          onChanged: (i) => setState(() => _currentPage = i),
          items: <NavigationPaneItem>[
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("Start")
            ),
            PaneItem(
                icon: const Icon(FluentIcons.database),
                title: const Text("Wszystkie rekordy z bazy danych")
            ),
            PaneItem(
                icon: const Icon(FluentIcons.calculated_table),
                title: const Text("Przekrój wiązki")
            ),
            PaneItem(
                icon: const Icon(FluentIcons.database_view),
                title: const Text("Part Base")
            ),
          ]
      ),

      content: NavigationBody(
        index: _currentPage,
        transitionBuilder: (child, animation) => EntrancePageTransition(child: child, animation: animation),
        children: const <Widget>[
          HomePage(),
          ReadData(),
          BundleCalculator(),
          mainui(),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: Text("Aplikacja mająca na celu wsparcie pracy inżyniera"));
}




