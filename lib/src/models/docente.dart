class Docente {
    final int id;
    final String nombre;
    final String apellidoP;
    final String apellidoM;

    Docente({
        required this.id,
        required this.nombre,
        required this.apellidoP,
        required this.apellidoM
    });

    factory Docente.fromJson(Map<String, dynamic> json) => Docente(
        id: json["id"],
        nombre: json["nombre"],
        apellidoP: json["apellidoP"],
        apellidoM: json["apellidoM"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellidoP": apellidoP,
        "apellidoM": apellidoM
    };
}

