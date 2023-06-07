import 'package:abc_pos/source/home/ui/HomePage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageActive = 'Home';

  _pageView() {
    switch (pageActive) {
      case "Home":
        return const HomePage();
      default:
        return const HomePage();
    }
  }

  _setPage(String page) {
    setState(() {
      pageActive = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 40),
      body: Row(children: [
        Container(
          width: 70,
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          height: MediaQuery.of(context).size.height,
          child: _sideMenu(),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 24, right: 12),
            padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Color(0xff17181f),
            ),
            child: _pageView(),
          ),
        ),
      ]),
    );
  }

  Widget _sideMenu() {
    return Column(children: [
      _logo(),
      const SizedBox(height: 10),
      Expanded(
          child: ListView(children: [
        _itemMenu(
          menu: 'Home',
          icon: Icons.rocket_sharp,
        ),
        _itemMenu(
          menu: 'Menu',
          icon: Icons.format_list_bulleted_rounded,
        ),
        _itemMenu(
          menu: 'History',
          icon: Icons.history_toggle_off_rounded,
        ),
        _itemMenu(
          menu: 'Promos',
          icon: Icons.discount_outlined,
        ),
        _itemMenu(
          menu: 'Settings',
          icon: Icons.sports_soccer_outlined,
        ),
      ]))
    ]);
  }

  Widget _logo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFCD8E00),
          ),
          child: const Icon(
            Icons.food_bank_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Antigua's Bake and Cuisine POS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _itemMenu({required String menu, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: GestureDetector(
        onTap: () => _setPage(menu),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: pageActive == menu
                    ? const Color(0xFFCD8E00)
                    : Colors.transparent,
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.slowMiddle,
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    menu,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
