import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';
import 'package:flutter_application_intraner/modelo/Curso.dart';
import 'package:flutter_application_intraner/modelo/Ruta.dart';
import 'package:flutter_application_intraner/vista/secundarioEst.dart';
import 'package:http/http.dart' as http;

class CursosEst extends StatefulWidget{
  const CursosEst({super.key});

  @override
  State<CursosEst> createState() => _CursosEstState();

}

class _CursosEstState extends State<CursosEst>{
  List<Curso> listaCursos = [];

  void llenarCursos()async{
    var url = Uri.parse("https://${Ruta.ip}/bdintranet/Controla.php?tag=listaCursos&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
      setState(() {
        List listaMap = json.decode(res.body)['dato'];
        listaCursos = listaMap.map((e) => Curso.fromJson(e)).toList();
      });
      print("Listado Alumnos realizado correctamente: ${listaCursos.length}");
    } else {
      print("Algo salió mal en el listado");
    }
    } catch (e) {
      print(e);
    }
    
  }

  @override
  void initState() {
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
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: listaCursos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),              
              child: ListTile(
                onTap: (){
                  Curso.sesionCurso = listaCursos[index];
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>MySecondApp()));
                },
                title: Text(listaCursos[index].nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Código: ${listaCursos[index].codigoCurso}        Cred.: ${listaCursos[index].creditos}        Tipo: ${listaCursos[index].tipo()}\nDocente: ${listaCursos[index].nombresProfesor} ${listaCursos[index].apellidosProfesor}')
              ),
            );
          },
        ),
      ),
    );
  }
}