import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';
import 'package:flutter_application_intraner/modelo/Asistencia.dart';
import 'package:flutter_application_intraner/modelo/Curso.dart';
import 'package:flutter_application_intraner/modelo/Ruta.dart';
import 'package:http/http.dart' as http;

class AsistenciaEst extends StatefulWidget{
  const AsistenciaEst({super.key});

  @override
  State<AsistenciaEst> createState() => _AsistenciaEstState();

}

class _AsistenciaEstState extends State<AsistenciaEst>{
  List<Asistencia> listaA = [];

  void llenarAsistencia()async{
    var url = Uri.parse("https://${Ruta.ip}/bdintranet/Controla.php?tag=asistenciaClase&codigo_clase=${Curso.sesionCurso!.codigoClase}&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    print(json.decode(res.body));
    try {
      if (res.statusCode == 200){
      setState(() {
        List listaMap = json.decode(res.body)['dato'];
        listaA = listaMap.map((e) => Asistencia.fromJson(e)).toList();
      });
      print("Listado Asistencia realizado correctamente: ${listaA.length}");
    } else {
      print("Algo salió mal en el listado");
    }
    } catch (e) {
      print(e);
    }
  }

  Color leyenda(String e){
    Color? cl;
    if (e == '0'){
      cl = Color.fromARGB(255, 255, 148, 148);
    } else if (e == '1'){
      cl = Color.fromARGB(255, 221, 255, 170);
    } else if (e == '2'){
      cl = Color.fromARGB(255, 255, 248, 214);
    } else if (e == '3'){
      cl = Color.fromARGB(255, 199, 240, 255);
    } else {
      cl = Color.fromARGB(255, 234, 234, 234);
    }

    return cl;
  }

  @override
  void initState() {
    super.initState();
    llenarAsistencia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 255, 148, 148),
                        ),
                        SizedBox(width: 6,),
                        Text('No asistió')
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 221, 255, 170),
                        ),
                        SizedBox(width: 6,),
                        Text('Asistió')
                      ],
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 255, 248, 214),
                        ),
                        SizedBox(width: 6,),
                        Text('Tardanza')
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 199, 240, 255),
                        ),
                        SizedBox(width: 6,),
                        Text('Justificado')
                      ],
                    )
                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                        SizedBox(width: 6,),
                        Text('No informa')
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: listaA.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: leyenda(listaA[index].estado), borderRadius: BorderRadius.circular(20)),              
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Center(child: Text("Semana ${listaA[index].semana}", style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}