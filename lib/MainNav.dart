import 'package:fluent_ui/fluent_ui.dart';
import 'package:partwindows/AddPart.dart';
import 'package:partwindows/ChangePart.dart';
import 'package:partwindows/BundleCalculator.dart';
import 'package:partwindows/Settings.dart';
import 'package:partwindows/SearchPart.dart';
import 'package:partwindows/DeletePart.dart';
import 'package:partwindows/read_data.dart';

class MainNav extends StatefulWidget {
  const MainNav({Key? key}) : super(key: key);

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int topIndex = 0;

  @override
  Widget build(BuildContext context) {
    //todo implement fluent_ui update (4.0.1)
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('Menu'),
      ),
      pane: NavigationPane(
          selected: topIndex,
          onChanged: (index) => setState(() => topIndex = index),
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("Start"),
                body: const HomePage()),
            PaneItem(
              icon: const Icon(FluentIcons.calculated_table),
              title: const Text("Przekrój wiązki"),
              body: const BundleCalculator(),
            ),
            PaneItemExpander(
                icon: const Icon(FluentIcons.database_view),
                title: const Text("Baza Części"),
                items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.database),
                    title: const Text("Wszystkie rekordy z bazy danych"),
                    body: const ReadData(),
                  ),
                  PaneItem(
                    icon: const Icon(FluentIcons.add),
                    title: const Text("Dodaj"),
                    body: const AddPart(),
                  ),
                  PaneItem(
                    icon: const Icon(FluentIcons.document_search),
                    title: const Text("Wyszukaj"),
                    body: const SearchPart(),
                  ),
                  PaneItem(
                    icon: const Icon(FluentIcons.change_entitlements),
                    title: const Text("Zmiana"),
                    body: const ChangePart(),
                  ),
                  PaneItem(
                    icon: const Icon(FluentIcons.delete_rows),
                    title: const Text("Usuń"),
                    body: const DeletePart(),
                  ),
                ],
                body: const PartBase()),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text("Ustawienia"),
              body: const Settings(),
            ),
          ]),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
      child: Text("Aplikacja mająca na celu wsparcie pracy inżyniera"));
}
class PartBase extends StatelessWidget {
  const PartBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
      child: Text("Baza danych części"));
}