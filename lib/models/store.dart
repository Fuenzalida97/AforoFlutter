import 'package:flutter/material.dart';

class Store {
  final String storeId;
  final String nombre;
  final int actual;
  final int capacidad;
  final String horaInicio;
  final String horaCierre;
  final String direccion;

  Store({@required this.storeId, this.nombre, this.actual, this.capacidad, this.horaInicio, this.horaCierre, this.direccion});

  factory Store.fromJson(Map<String, dynamic> json){
    return Store(
      storeId: json['storeId'],
      nombre: json['nombre'],
      actual: json['actual'],
      capacidad: json['capacidad'],
      horaInicio: json['horaInicio'],
      horaCierre: json['horaCierre'],
      direccion: json['direccion']
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'storeId': storeId,
      'nombre': nombre,
      'actual': actual,
      'capacidad': capacidad,
      'horaInicio': horaInicio,
      'horaCierre': horaCierre,
      'direccion': direccion
    };
  }
}