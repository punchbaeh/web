import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/main.dart';
import 'package:flutter_application_intraner/modelo/Alumno.dart';

import 'package:flutter_application_intraner/vista/actualizaEst.dart';

class PersonalEst extends StatefulWidget{
  const PersonalEst({super.key});

  @override
  State<PersonalEst> createState() => _PersonalEstState();

}

class _PersonalEstState extends State<PersonalEst>{
  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),
                child: Text('Código de estudiante: ${Alumno.sesionAlumno!.codigo}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15,),
              ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.network('https://intranetappfsoucss.000webhostapp.com/bdintranet/image.php?file=${Alumno.sesionAlumno!.codigo}.jpg', width: 200, height: 300, fit: BoxFit.cover),),
              SizedBox(height: 15,),
              BarcodeWidget(
                barcode: Barcode.code128(), // Define el tipo de código de barras
                data: '${Alumno.sesionAlumno!.codigo} ${Alumno.sesionAlumno!.apellidoPaterno}', // Datos para el código de barras
                width: 300, // Ancho del código de barras
                height: 100, // Altura del código de barras
                drawText: false, // Para mostrar/ocultar los datos en texto debajo del código de barras
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color.fromARGB(255, 214, 234, 248), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Alumno.sesionAlumno!.getLabels(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                    SizedBox(width: 10,),
                    Text(Alumno.sesionAlumno!.getValues(), style: TextStyle(fontSize: 14))
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyActualiza()));
                  }, child: Text('Actualizar datos',style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255,1,161,197))),
                  SizedBox(width: 20,),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyApp()));
                  }, child: Text('Cerrar Sesión',style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}