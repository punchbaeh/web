class Curso {
  String codigoClase;
  String codigoCurso;
  String nombre;
  int creditos;
  String tipoCurso;
  int ciclo;
  String codigoProfesor;
  String nombresProfesor;
  String apellidosProfesor;
  static Curso? sesionCurso;

  Curso({
    required this.codigoClase,
    required this.codigoCurso,
    required this.nombre,
    required this.creditos,
    required this.tipoCurso,
    required this.ciclo,
    required this.codigoProfesor,
    required this.nombresProfesor,
    required this.apellidosProfesor,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      codigoClase: json['codigo_clase'],
      codigoCurso: json['codigo_curso'],
      nombre: json['nombre'],
      creditos: int.parse(json['creditos']),
      tipoCurso: json['tipo_curso'],
      ciclo: int.parse(json['ciclo']),
      codigoProfesor: json['codigo_profesor'],
      nombresProfesor: json['nombres_profesor'],
      apellidosProfesor: json['apellidos_profesor'],
    );
  }

  String tipo(){
    return tipoCurso=="1"?"O":"E";
  }
}
