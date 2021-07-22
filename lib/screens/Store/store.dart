import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  final Store store;
  StoreScreen({this.store});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  final nombreController = TextEditingController();
  final actualController = TextEditingController();
  final capacidadController = TextEditingController();
  final horaInicioController = TextEditingController();
  final horaCierreController = TextEditingController();
  final direccionController = TextEditingController();


  @override
  void dispose() {
    nombreController.dispose();
    actualController.dispose();
    capacidadController.dispose();
    horaInicioController.dispose();
    horaCierreController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final storeProvider = Provider.of<AuthServices>(context, listen: false);
    if(widget.store != null){
      //Edit
      nombreController.text = widget.store.nombre;
      actualController.text = widget.store.actual.toString();
      capacidadController.text = widget.store.capacidad.toString();
      horaInicioController.text = widget.store.horaInicio;
      horaCierreController.text = widget.store.horaCierre;
      direccionController.text = widget.store.direccion;

      storeProvider.loadAll(widget.store);
    }else{
      //Add
      storeProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<AuthServices>(context);
    var tienda = widget.store.nombre;
    return  Scaffold(
      appBar: AppBar(title: Text('Información de Tienda'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/fondo.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),

          child: ListView(

            children: [
              TextField(
                enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Tienda :',
                  ),
                onChanged: (String value) => storeProvider.changeNombre = value,
                controller: nombreController,
              ),
                TextField(
                  enabled: false,
                decoration: InputDecoration(
                  labelText: 'Cantidad de personas en tienda  :',
                ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                keyboardType: TextInputType.number,
                controller: actualController,
                onChanged: (String value) => storeProvider.changeActual = value as int,
              ),

              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Capacidad máxima de personas :',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.number,
                controller: capacidadController,
                onChanged: (String value) => storeProvider.changeActual = value as int,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Hora de apertura :',
                ),
                onChanged: (String value) => storeProvider.changeHoraInicio = value,
                controller: horaInicioController,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Hora de Cierre :',
                ),
                onChanged: (String value) => storeProvider.changeHoraCierre = value,
                controller: horaCierreController,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Dirección de tienda :',
                ),
                onChanged: (String value) => storeProvider.changeDireccion = value,
                controller: direccionController,
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text('Volver', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              /*
              RaisedButton(
                color: Colors.blueAccent,
                child: Text('Save', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  storeProvider.saveStore();
                  Navigator.of(context).pop();
                },
              ),

              (widget.store != null) ?
              RaisedButton(
                color: Colors.red,
                child: Text('Delete', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  storeProvider.removeStore(widget.store.storeId);
                  Navigator.of(context).pop();
                },
              ):Container(),
              */
            ],
          ),
        ),
      ),
    );
  }
}
