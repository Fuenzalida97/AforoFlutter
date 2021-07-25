import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/models/usuario.dart';
import 'package:aforo_app/screens/Authentication/authentication.dart';
import 'package:aforo_app/screens/Authentication/login.dart';
import 'package:aforo_app/screens/Store/store.dart';
import 'package:aforo_app/screens/Store/store_count.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:aforo_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

    AuthServices authServices = new AuthServices();

    var _tienda;
    var _rol;

    void tienda() async {
      _tienda = await authServices.getTienda();
    }
    void rol() async {
      _rol = await authServices.getRol();
    }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    rol();
    tienda();
    return Scaffold(
      appBar: AppBar(
        title: Text("Aforo Tiendas"),
        actions:[
          IconButton(
            icon:Icon(Icons.exit_to_app),
            onPressed: () async => await loginProvider.logout(),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/fondo.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder<List<Store>>(
            stream: loginProvider.stores,
            builder: (context, snapshot){
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index){
                    return Card(
                    child: ListTile(
                        tileColor: Colors.transparent,
                      //leading: Icon(Icons.store, color: Colors.redAccent),
                      trailing: Text((snapshot.data[index].actual).toString()+ ' / '+(snapshot.data[index].capacidad).toString()),
                      title: Text(snapshot.data[index].nombre),
                      subtitle: Text('Horario: '+(snapshot.data[index].horaInicio)+ ' - '+(snapshot.data[index].horaCierre)),
                      onTap:(){
                          if(_rol == '[contador]' && _tienda == '['+(snapshot.data[index].nombre).toString()+']'){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreCountScreen(store: snapshot.data[index])));
                            }else{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreScreen(store: snapshot.data[index])));
                          }
                      }
                    ),
                    );
                  });
            },
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StoreScreen()));
        },
      ),*/
    );
  }
}
