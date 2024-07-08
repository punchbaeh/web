class Profesor {
  String codigo;
  int dni;
  String nombres;
  String apellidos;
  int numeroCelular;
  String especialidad;
  int licenciatura;
  int maestria;
  int doctorado;
  static Profesor? sesionProfesor;

  Profesor({
    required this.codigo,
    required this.dni,
    required this.nombres,
    required this.apellidos,
    required this.numeroCelular,
    required this.especialidad,
    required this.licenciatura,
    required this.maestria,
    required this.doctorado,
  });

  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      codigo: json['codigo_profesor'],
      dni: int.parse(json['dni']),
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      numeroCelular: int.parse(json['numero_celular']),
      especialidad: json['especialidad'],
      licenciatura: int.parse(json['licenciatura']),
      maestria: int.parse(json['maestria']),
      doctorado: int.parse(json['doctorado']),
    );
  }

  String getLabels() {
    return '''
DNI: 
Nombres: 
Apellidos: 
Número Celular: 
Especialidad: 
Licenciatura: 
Maestría: 
Doctorado: 
    ''';
  }

  String getValues() {
    return '''
$dni
$nombres
$apellidos
$numeroCelular
$especialidad
${documentos(licenciatura)}
${documentos(maestria)}
${documentos(doctorado)}
    ''';
  }

  String documentos(int i){
    return i==1?'Sí':'No';
  }
}

