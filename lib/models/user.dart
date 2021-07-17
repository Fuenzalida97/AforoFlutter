class User {
  final String id;
  final String email;
  final String rol;
  final String tienda;

  User({this.id, this.email, this.rol, this.tienda});

  User.fromData(Map<String, dynamic> data)
    : id = data['id'],
        email = data['email'],
        rol = data['rol'],
        tienda = data['tienda'];

    Map<String, dynamic> toJson(){
      return{
        'id': id,
        'email': email,
        'rol': rol,
        'tienda': tienda
      };
    }
}