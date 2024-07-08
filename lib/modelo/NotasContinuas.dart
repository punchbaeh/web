class NotasContinuas {
  String codigoClase;
  String codigoEstudiante;
  int numero;
  double nota;
  static List<NotasContinuas>? sesionContinuas;

  NotasContinuas({
    required this.codigoClase,
    required this.codigoEstudiante,
    required this.numero,
    required this.nota,
  });

  factory NotasContinuas.fromJson(Map<String, dynamic> json) {
    return NotasContinuas(
      codigoClase: json['codigo_clase'],
      codigoEstudiante: json['codigo_estudiante'],
      numero: int.parse(json['numero']),
      nota: double.parse(json['nota']),
    );
  }

  @override
  String toString() {
    return 'Codigo Clase: $codigoClase\n'
           'Codigo Estudiante: $codigoEstudiante\n'
           'Numero: $numero\n'
           'Nota: $nota';
  }

  String toStringLabels() {
    return 'Codigo Clase:\n'
           'Codigo Estudiante:\n'
           'Numero:\n'
           'Nota:';
  }

  String toStringValues() {
    return '$codigoClase\n'
           '$codigoEstudiante\n'
           '$numero\n'
           '$nota';
  }

  
}
