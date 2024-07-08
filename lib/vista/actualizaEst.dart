import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/main.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';
import 'package:flutter_application_intraner/modelo/Ruta.dart';
import 'package:flutter_application_intraner/vista/principalEst.dart';
import 'package:http/http.dart' as http;

class MyActualiza extends StatefulWidget{
  const MyActualiza({super.key});

  @override
  State<MyActualiza> createState() => _MyActualizaState();

}

class _MyActualizaState extends State<MyActualiza>{
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidoP = TextEditingController();
  TextEditingController apellidoM = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController dir = TextEditingController();

  void actualizarAlumno() async {
    final response = await http.post(
      Uri.parse('https://${Ruta.ip}/bdintranet/Controla.php'),
      body: {
        'tag':'actualizarAlumno',
        'codigo_estudiante': Alumno.sesionAlumno!.codigo,
        'nombres': nombre.text,
        'apellido_paterno': apellidoP.text,
        'apellido_materno': apellidoM.text,
        'numero_celular': numero.text,
        'direccion': dir.text,
      },
    );

    if (response.statusCode == 200) {
      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alumno actualizado con éxito ${response.statusCode}')),
      );
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar alumno')),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre.text = Alumno.sesionAlumno!.nombres;
    apellidoP.text = Alumno.sesionAlumno!.apellidoPaterno;
    apellidoM.text = Alumno.sesionAlumno!.apellidoMaterno;
    numero.text = Alumno.sesionAlumno!.numeroCelular.toString();
    dir.text = Alumno.sesionAlumno!.direccion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyPrincipalHomePage(i:0)));
        }, icon: Icon(Icons.keyboard_return, color: Colors.white,),),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Text('Actualización de datos',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextField(controller: nombre, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar nombre'),),
              SizedBox(height: 7,),
              TextField(controller: apellidoP, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar apellido Paterno'),),
              SizedBox(height: 7,),
              TextField(controller: apellidoM, decoration: InputDecoration(icon: Icon(Icons.abc), hintText: 'Actualizar apellido Materno'),),
              SizedBox(height: 7,),
              TextField(controller: numero, decoration: InputDecoration(icon: Icon(Icons.numbers), hintText: 'Actualizar número celular'),),
              SizedBox(height: 7,),
              TextField(controller: dir, decoration: InputDecoration(icon: Icon(Icons.maps_home_work), hintText: 'Actualizar dirección'),),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                try {
                  actualizarAlumno();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Actualización con exito'),
                        content: Text('Se procederá a cerrar la sesión.'),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyApp()));
                            },
                            icon: Icon(Icons.keyboard_return, color: Colors.red,),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Actualización fallida'),
                        content: Text('ALGO SALIO MAL :C'),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.keyboard_return, color: Colors.red,),
                          ),
                        ],
                      );
                    },
                  );
                }
              }, child: Text('Registrar actualización',style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255,1,161,197))),
            ],
          ),
        ),
      )
    );
  }
}