import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';
import 'package:flutter_application_intraner/modelo/Curso.dart';
import 'package:flutter_application_intraner/modelo/NotasContinuas.dart';
import 'package:flutter_application_intraner/modelo/NotasParciales.dart';
import 'package:flutter_application_intraner/modelo/Ruta.dart';
import 'package:http/http.dart' as http;

class HistorialEst extends StatefulWidget{
  const HistorialEst({super.key});

  @override
  State<HistorialEst> createState() => _HistorialEstState();

}

class _HistorialEstState extends State<HistorialEst>{
  int bus = 1;
  List<Curso> listaH = [];
  List<Curso> filtrada = [];
  List<NotasParciales> notasPH = [];
  List<NotasContinuas> notasCH = [];
  void llenarCursos()async{
    var url = Uri.parse("https://${Ruta.ip}/bdintranet/Controla.php?tag=historial&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
      setState(() {
        List listaMap = json.decode(res.body)['dato'];
        listaH = listaMap.map((e) => Curso.fromJson(e)).toList();
        filtrada = listaH;
      });
      print("Listado Historial realizado correctamente: ${listaH.length}");
    } else {
      print("Algo salió mal en el listado");
    }
    } catch (e) {
      print(e);
    }
  }

    void llenarParciales(String cod)async{
    var url = Uri.parse("http://${Ruta.ip}/bdintranet/Controla.php?tag=notasParciales&codigo_clase=$cod&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
      setState(() {
        List listaMap = json.decode(res.body)['dato'];
        notasPH = listaMap.map((e) => NotasParciales.fromJson(e)).toList();
      });
      print("Listado notasPH realizado correctamente: ${notasPH.length}");
    } else {
      print("Algo salió mal en el listado");
    }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    llenarCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: Image.asset('assets/logo.png'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(icon: Icon(Icons.search)), onChanged: (x){
              setState(() {
                
                if (bus == 1){
                  filtrada = listaH.where((c)=>c.nombre.contains(x)).toList();
                } else if (bus == 2){
                  int ci = int.tryParse(x)??0;
                  filtrada = listaH.where((c)=>c.ciclo==ci).toList();
                } else {
                  String prof = x.toUpperCase();
                  filtrada = listaH.where((c)=>c.apellidosProfesor.contains(prof)).toList();
                }
              });
            },),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  RadioListTile(title: Text('Curso'), value: 1, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  }),
                  RadioListTile(title: Text('Ciclo'), value: 2, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  }),
                  RadioListTile(title: Text('Profesor'), value: 3, groupValue: bus, onChanged: (x){
                    setState(() {
                      bus = x!;
                    });
                  })                                   
                ],
              ),
            ),
            SizedBox(height: 10,),
            ListTile(title: Text('Ciclo   Curso y docente                   Creditos'),),
            Expanded(
              child: ListView.builder(
              itemCount: filtrada.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text('${filtrada[index].ciclo}'),
                        title: Text('${filtrada[index].nombre}'),
                        subtitle: Text('${filtrada[index].apellidosProfesor}'),
                        trailing: Text('${filtrada[index].creditos}'),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
            )
          ],
        ),
      )

      );
  }
}