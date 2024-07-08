class Alumno {
  String codigo;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String fechaNacimiento;
  String nombreFacultad;
  String nombreCarrera;
  int cicloIngreso;
  int dni;
  int numeroCelular;
  String direccion;
  static Alumno? sesionAlumno;

  Alumno({
    required this.codigo,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.nombreFacultad,
    required this.nombreCarrera,
    required this.cicloIngreso,
    required this.dni,
    required this.numeroCelular,
    required this.direccion,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      codigo: json['codigo_estudiante'],
      nombres: json['nombres'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      fechaNacimiento: json['fecha_nacimiento'],
      nombreFacultad: json['nombre_facultad'],
      nombreCarrera: json['nombre_carrera'],
      cicloIngreso: int.parse(json['ciclo_ingreso']),
      dni: int.parse(json['dni']),
      numeroCelular: int.parse(json['numero_celular']),
      direccion: json['direccion'],
    );
  }
  
  // Función para obtener solo las etiquetas
  String getLabels() {
    return 
           'Nombres: \n'
           'Apellido Paterno: \n'
           'Apellido Materno: \n'
           'Fecha de Nacimiento: \n'
           'Nombre de Facultad: \n'
           'Nombre de Carrera: \n'
           'Ciclo de Ingreso: \n'
           'DNI: \n'
           'Numero de Celular: \n'
           'Direccion:';
  }

  // Función para obtener solo los valores
  String getValues() {
    return 
           '$nombres\n'
           '$apellidoPaterno\n'
           '$apellidoMaterno\n'
           '$fechaNacimiento\n'
           '$nombreFacultad\n'
           '$nombreCarrera\n'
           '$cicloIngreso\n'
           '$dni\n'
           '$numeroCelular\n'
           '$direccion';
  }
}
