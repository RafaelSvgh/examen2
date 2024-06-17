class Asistencias {
  List<Asistencia> items = [];
  Asistencias();
  Asistencias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) {
      return;
    }
    for (var item in jsonList) {
      final asistencia = new Asistencia.fromJson(item);
      items.add(asistencia);
    }
  }
}

class Asistencia {
  final int id;
  String estado;
  final DateTime fecha;
  final String hora;
  String observacion;
  final String dia;
  final String aula;
  final String modulo;
  final String horaInicio;
  final String horaFin;
  final int horarioId;

  Asistencia({
    required this.id,
    required this.estado,
    required this.fecha,
    required this.hora,
    required this.observacion,
    required this.dia,
    required this.aula,
    required this.modulo,
    required this.horaInicio,
    required this.horaFin,
    required this.horarioId,
  });


  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
        id: json["id"],
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        observacion: json["observacion"],
        dia: json["dia"],
        aula: json["aula"],
        modulo: json["modulo"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
        horarioId: json["horarioId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "estado": estado,
        "fecha": fecha.toIso8601String(),
        "hora": hora,
        "observacion": observacion,
        "dia": dia,
        "aula": aula,
        "modulo": modulo,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
        "horarioId": horarioId,
      };
}
