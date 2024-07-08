import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/vista/asistenciaEst.dart';
import 'package:flutter_application_intraner/vista/notasEst.dart';
import 'package:flutter_application_intraner/vista/principalEst.dart';

class MySecondApp extends StatelessWidget{
  const MySecondApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menú 2',
      home: MySecondHomePage()
    );
  }
}

class MySecondHomePage extends StatefulWidget{
  const MySecondHomePage({super.key});
  
  @override
  State<MySecondHomePage> createState() => _MySecondHomePageState();
}

class _MySecondHomePageState extends State<MySecondHomePage>{
  int _selectedIndex = 0;

  List<Widget> _screens = [
    NotasEst(),
    AsistenciaEst()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyPrincipalHomePage(i: 1,)));
        }, icon: Icon(Icons.keyboard_return, color: Colors.white,),),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notas'),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt_sharp), label: 'Asistencias'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255,1,161,197),
        onTap: _onItemTapped,
      ),
    );
  }
  
}