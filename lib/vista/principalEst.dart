
import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/vista/cursosEst.dart';
import 'package:flutter_application_intraner/vista/historialEst.dart';
import 'package:flutter_application_intraner/vista/personalEst.dart';



class MyPrincipalHomePage extends StatefulWidget{
  final int i;
  const MyPrincipalHomePage({super.key, required this.i});
  
  @override
  State<MyPrincipalHomePage> createState() => _MyPrincipalHomePageState();
}

class _MyPrincipalHomePageState extends State<MyPrincipalHomePage>{
  int _selectedIndex = 0;
  List<Widget> _screens = [
    PersonalEst(),
    CursosEst(),
    HistorialEst(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.i;
  }

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Cursos'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255,1,161,197),
        onTap: _onItemTapped,
      ),
    );
  }
  
}