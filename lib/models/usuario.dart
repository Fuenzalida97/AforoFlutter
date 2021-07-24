import 'package:flutter/material.dart';

class Usuario {
  final String id;
  final String email;
  final String rol;
  final String tienda;

  Usuario({@required this.id, this.email, this.rol, this.tienda});


  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
        id: json['id'],
        email: json['email'],
        rol: json['rol'],
        tienda: json['tienda']
    );
  }
    Map<String, dynamic> toMap(){
      return{
        'id': id,
        'email': email,
        'rol': rol,
        'tienda': tienda
      };
    }
}