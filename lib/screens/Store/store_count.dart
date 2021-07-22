import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreCountScreen extends StatefulWidget {
  final Store store;

  StoreCountScreen({this.store});

  @override
  _StoreCountScreenState createState() => _StoreCountScreenState();

}

class _StoreCountScreenState extends State<StoreCountScreen> {
  int _count = 0;

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
    if (widget.store != null) {
      //Edit
      nombreController.text = widget.store.nombre;
      actualController.text = widget.store.actual.toString();
      capacidadController.text = widget.store.capacidad.toString();
      horaInicioController.text = widget.store.horaInicio;
      horaCierreController.text = widget.store.horaCierre;
      direccionController.text = widget.store.direccion;
      _count = widget.store.actual;
      storeProvider.loadAll(widget.store);
    } else {
      //Add
      storeProvider.loadAll(null);
    }
    super.initState();
  }


  _incrementCounter() {
    setState(() {
    final storeProvider = Provider.of<AuthServices>(context, listen: false);
      _count++;
      storeProvider.loadAll(widget.store);
    });
  }

  _decrementCounter() {
    setState(() {
      final storeProvider = Provider.of<AuthServices>(context, listen: false);
      _count--;
      storeProvider.loadAll(widget.store);
    });
  }



  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<AuthServices>(context);
    var tienda = widget.store.nombre;
    var total = widget.store.capacidad;
    return Scaffold(
      appBar: AppBar(
        title: Text('Aforo de $tienda'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fondo.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cantidad Actual de Personas:',
                style: TextStyle(fontSize:25.0),
              ),
              SizedBox(height: 20),
              Text(
                '$_count / $total',
                style: TextStyle(fontSize:55.0),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "increment",
                    child: Icon(Icons.arrow_upward),
                    backgroundColor: Colors.blueAccent,
                    tooltip: 'Incrementar',
                    onPressed: () {
                        _incrementCounter();
                        storeProvider.updateStore2(_count);
                    },
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: "decrement",
                    child: Icon(Icons.arrow_downward),
                    backgroundColor: Colors.redAccent,
                    tooltip: 'Disminuir',
                    onPressed: () {
                      setState(() {
                        _decrementCounter();
                        storeProvider.updateStore2(_count);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
