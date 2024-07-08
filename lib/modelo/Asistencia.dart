class Asistencia {
  String codigoClase;
  String codigoEstudiante;
  int semana;
  String estado;

  Asistencia({
    required this.codigoClase,
    required this.codigoEstudiante,
    required this.semana,
    required this.estado,
  });

  factory Asistencia.fromJson(Map<String, dynamic> json) {
    return Asistencia(
      codigoClase: json['codigo_clase'],
      codigoEstudiante: json['codigo_estudiante'],
      semana: int.parse(json['semana']),
      estado: json['estado'],
    );
  }
}