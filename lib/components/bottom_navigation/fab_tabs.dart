import 'package:flutter/material.dart';
import 'package:myvan_flutter/pages/home.dart';
import 'package:myvan_flutter/pages/motorista.dart';
import 'package:myvan_flutter/pages/passageiro.dart';
import 'package:myvan_flutter/pages/tipo_veiculo.dart';
import 'package:myvan_flutter/pages/veiculo.dart';
import 'package:myvan_flutter/pages/viagem.dart';

class FabTabs extends StatefulWidget {
  int selectedIndex = 0;
  FabTabs({required this.selectedIndex, super.key});

  @override
  State<FabTabs> createState() => _FabTabsState();
}

class _FabTabsState extends State<FabTabs> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    super.initState();
  }

  final List<Widget> pages = [
    const Home(),
    const PassageiroPage(),
    const MotoristaPage(),
    const VeiculoPage(),
    const TipoVeiculoPage(),
    const ViagemPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentIndex == 0
        ? const Home()
        : currentIndex == 1
            ? const PassageiroPage()
            : currentIndex == 2
                ? const MotoristaPage()
                : currentIndex == 3
                    ? const VeiculoPage()
                    : currentIndex == 4
                        ? const VeiculoPage()
                        : currentIndex == 5
                            ? const ViagemPage()
                            : const TipoVeiculoPage();

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Centraliza os elementos na linha
            children: [
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const Home();
                    currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_filled,
                      color: currentIndex == 0
                          ? const Color.fromARGB(255, 196, 196, 196)
                          : Colors.white,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: currentIndex == 0
                              ? const Color.fromARGB(255, 196, 196, 196)
                              : Colors.white),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const PassageiroPage();
                    currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_alt,
                      color: currentIndex == 1
                          ? const Color.fromARGB(255, 196, 196, 196)
                          : Colors.white,
                    ),
                    Text(
                      "Passageiros",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: currentIndex == 1
                              ? const Color.fromARGB(255, 196, 196, 196)
                              : Colors.white),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const ViagemPage();
                    currentIndex = 5;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_pin_circle_rounded,
                      color: currentIndex == 5
                          ? const Color.fromARGB(255, 196, 196, 196)
                          : Colors.white,
                    ),
                    Text(
                      "Viagens",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: currentIndex == 5
                              ? const Color.fromARGB(255, 196, 196, 196)
                              : Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
