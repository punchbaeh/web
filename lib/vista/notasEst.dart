import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';
import 'package:flutter_application_intraner/modelo/Curso.dart';
import 'package:flutter_application_intraner/modelo/NotasContinuas.dart';
import 'package:flutter_application_intraner/modelo/NotasParciales.dart';
import 'package:flutter_application_intraner/modelo/Profesor.dart';
import 'package:flutter_application_intraner/modelo/Ruta.dart';
import 'package:flutter_application_intraner/vista/graficosEst.dart';
import 'package:http/http.dart' as http;

class NotasEst extends StatefulWidget {
  const NotasEst({super.key});

  @override
  State<NotasEst> createState() => _NotasEstState();
}

class _NotasEstState extends State<NotasEst> {
  List<NotasParciales> notas = [];
  List<NotasContinuas> notasC = [];
  Profesor? profesor;
  bool isLoadingParciales = true;
  bool isLoadingContinuas = true;
  bool isLoadingProfesor = true;

  Future<void> llenarProfesor() async {
    var url = Uri.parse("https://${Ruta.ip}/bdintranet/Controla.php?tag=listaProfesores");
    var res = await http.post(url);
    try {
      if (res.statusCode == 200) {
        List listaMap = json.decode(res.body)['dato'];
        List<Profesor> listaProf = listaMap.map((x) => Profesor.fromJson(x)).toList();
        setState(() {
          profesor = listaProf.firstWhere((e) => e.codigo == Curso.sesionCurso!.codigoProfesor);
          isLoadingProfesor = false;
        });
      } else {
        print("Algo salió mal en el listado de profesores");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> llenarParciales() async {
    var url = Uri.parse(
        "https://${Ruta.ip}/bdintranet/Controla.php?tag=notasParciales&codigo_clase=${Curso.sesionCurso!.codigoClase}&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    try {
      if (res.statusCode == 200) {
        List listaMap = json.decode(res.body)['dato'];
        setState(() {
          notas = listaMap.map((e) => NotasParciales.fromJson(e)).toList();
          NotasParciales.sesionParciales = notas[0];
          isLoadingParciales = false;
        });
      } else {
        print("Algo salió mal en el listado de notas parciales");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> llenarContinuas() async {
    var url = Uri.parse(
        "https://${Ruta.ip}/bdintranet/Controla.php?tag=notasContinuas&codigo_clase=${Curso.sesionCurso!.codigoClase}&codigo_estudiante=${Alumno.sesionAlumno!.codigo}");
    var res = await http.post(url);
    try {
      if (res.statusCode == 200) {
        List listaMap = json.decode(res.body)['dato'];
        setState(() {
          notasC = listaMap.map((e) => NotasContinuas.fromJson(e)).toList();
          NotasContinuas.sesionContinuas = notasC;
          isLoadingContinuas = false;
        });
      } else {
        print("Algo salió mal en el listado de notas continuas");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    llenarProfesor();
    llenarParciales();
    llenarContinuas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              Curso.sesionCurso!.nombre,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 234, 248),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoadingParciales ? "Cargando..." : NotasParciales.sesionParciales!.toStringLabels(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(width: 10),
                  Text(
                    isLoadingParciales ? "" : NotasParciales.sesionParciales!.toStringValues(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isLoadingProfesor
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Información del profesor'),
                                content: SingleChildScrollView(
                                  padding: EdgeInsets.all(15),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 214, 234, 248),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Código de docente: ${profesor!.codigo ?? ""}',
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://intranetappfsoucss.000webhostapp.com/bdintranet/image.php?file=${profesor!.codigo}.jpg',
                                            width: 150,
                                            height: 250,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 214, 234, 248),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  profesor!.getLabels() ?? "",
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(width: 10),
                                                Text(profesor!.getValues() ?? "", style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.keyboard_return, color: Colors.red),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: Text('Ver profesor', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 1, 161, 197)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => MyGraficos()));
                  },
                  child: Text('Ver gráficos', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 1, 161, 197)),
                ),
              ],
            ),
            Expanded(
              child: isLoadingContinuas
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: notasC.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Continua ${notasC[index].numero}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Nota: ${notasC[index].nota}'),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
