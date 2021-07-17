import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';

class StoreCountScreen extends StatefulWidget {
  final Store store;
  StoreCountScreen({this.store});

  @override
  _StoreCountScreenState createState() => _StoreCountScreenState();
}

class _StoreCountScreenState extends State<StoreCountScreen> {

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

  _incrementCounter(int value) {
      value++;
      return value;
  }


  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<AuthServices>(context);
    var cant = widget.store.actual;
    var cant2 = 0;
    return  Scaffold(
      appBar: AppBar(title: Text('Información de Tienda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(

          children: [
            /*StreamBuilder<List<Store>>(
              return Text
              stream: storeProvider.stores,
              builder: (context, snapshot){
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index){
                      return ListTile(
                          trailing:
                          Icon(Icons.add, color: Colors.redAccent),
                          title: Text(snapshot.data[index].nombre
                          ),
                          onTap:(){
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreScreen(store: snapshot.data[index])));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreCountScreen(store: snapshot.data[index])));
                          }
                      );
                    });
              },
            ),*/
            Text(
              '$cant'
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Capacidad máxima de personas :',
              ),
              controller: actualController,
              onChanged: (String value) => storeProvider.changeActual = value.length,
            ),
            SizedBox(height: 50),
            FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              elevation: 70.0,
              backgroundColor: Colors.blueAccent,
              onPressed: (){
                cant2 = _incrementCounter(cant);
                storeProvider.updateStore2(cant2);
                cant = cant2;
              },
            ),
          ],
        ),
      ),
    );
  }
}
