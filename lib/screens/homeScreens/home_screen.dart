import 'package:aforo_app/models/store.dart';
import 'package:aforo_app/screens/Store/store.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<List<Store>>(
          stream: loginProvider.stores,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreScreen(store: snapshot.data[index])));
                    }
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StoreScreen()));
        },
      ),
    );
  }
}
