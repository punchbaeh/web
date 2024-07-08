import 'package:flutter_application_intraner/modelo/NPChartBar.dart';

class NotasParciales {
  String codigoEstudiante;
  String codigoClase;
  double? parcial1;
  double? parcial2;
  double? parcial3;
  double? exaFinal;
  static NotasParciales? sesionParciales;

  NotasParciales({
    required this.codigoEstudiante,
    required this.codigoClase,
    required this.parcial1,
    required this.parcial2,
    required this.parcial3,
    required this.exaFinal,
  });

  factory NotasParciales.fromJson(Map<String, dynamic> json) {
    return NotasParciales(
      codigoEstudiante: json['codigo_estudiante'],
      codigoClase: json['codigo_clase'],
      parcial1: double.parse(json['parcial_1']),
      parcial2: double.parse(json['parcial_2']),
      parcial3: double.parse(json['parcial_3']),
      exaFinal: double.parse(json['exa_final']),
    );
  }

  @override
  String toString() {
    return 'Codigo Estudiante: $codigoEstudiante\n'
           'Codigo Clase: $codigoClase\n'
           'Parcial 1: $parcial1\n'
           'Parcial 2: $parcial2\n'
           'Parcial 3: $parcial3\n'
           'Examen Final: $exaFinal';
  }

  String toStringLabels() {
    return 
           'Parcial 1:\n'
           'Parcial 2:\n'
           'Parcial 3:\n'
           'Examen Final:';
  }

  String toStringValues() {
    return 
           '${parcial1??0}\n'
           '${parcial2??0}\n'
           '${parcial3??0}\n'
           '${exaFinal??0}';
  }
  List<Dato> parciales(){
    return [
      Dato(x:"Parcial 1",y:this.parcial1!),
      Dato(x:"Parcial 2",y:this.parcial2!),
      Dato(x:"Parcial 3",y:this.parcial3!),
      Dato(x:"Final",y:this.exaFinal!),
    ];
  }
}
