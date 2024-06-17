class Usuario {
    final String message;
    final String token;
    final String username;

    Usuario({
        required this.message,
        required this.token,
        required this.username,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        message: json["Message"],
        token: json["token"],
        username: json["username"]
    );

    Map<String, dynamic> toJson() => {
        "Message": message,
        "token": token,
        "username": username
    };
}
