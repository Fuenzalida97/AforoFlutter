class User {
  final String id;
  final String email;
  final String role;

  User({this.id, this.email, this.role});

  User.fromData(Map<String, dynamic> data)
    : id = data['id'],
        email = data['email'],
        role = data['role'];

    Map<String, dynamic> toJson(){
      return{
        'id': id,
        'email': email,
        'role': role,
      };
    }
}