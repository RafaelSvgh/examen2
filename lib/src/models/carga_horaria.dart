class CargaHorarias {
  List<CargaHoraria> items = [];
  CargaHorarias();
  CargaHorarias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) {
      return;
    }
    for (var item in jsonList) {
      final cargaHoraria = new CargaHoraria.fromJson(item);
      items.add(cargaHoraria);
    }
  }
}

class CargaHoraria {
  final int id;
  final String gestion;
  final String grupo;
  final String materia;
  final String carrera;
  final List<Horario> horarios;

  CargaHoraria({
    required this.id,
    required this.gestion,
    required this.grupo,
    required this.materia,
    required this.carrera,
    required this.horarios,
  });

  factory CargaHoraria.fromJson(Map<String, dynamic> json) => CargaHoraria(
        id: json["id"],
        gestion: json["gestion"],
        grupo: json["grupo"],
        materia: json["materia"],
        carrera: json["carrera"],
        horarios: List<Horario>.from(
            json["horarios"].map((x) => Horario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gestion": gestion,
        "grupo": grupo,
        "materia": materia,
        "carrera": carrera,
        "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
      };
}

class Horario {
  final int id;
  final String dia;
  final String horaInicio;
  final String horaFin;
  final String aula;

  Horario({
    required this.id,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.aula,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json["id"],
        dia: json["dia"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
        aula: json["aula"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dia": dia,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
        "aula": aula,
      };
}
