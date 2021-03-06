import 'package:aforo_app/main.dart';
import 'package:aforo_app/screens/homeScreens/home_screen.dart';
import 'package:aforo_app/services/authentication_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  const Login({Key key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return ChangeNotifierProvider(
      create: (context) => AuthServices(),
      child: MaterialApp(
        home: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      "Bienvenido de nuevo",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Regístrate para continuar",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      validator: (val) => val.isNotEmpty
                          ? null
                          : "Por favor ingrese una dirección de correo electrónico",
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      validator: (val) =>
                          val.length < 6 ? "Ingrese más de 6 caracteres" : null,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: "Contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(height: 15),
                    if (loginProvider.errorMessage != null)
                      Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          color: Colors.amberAccent,
                          child: ListTile(
                            title: Text(loginProvider.errorMessage),
                            leading: Icon(Icons.error),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => loginProvider.setMessage(null),
                            ),
                          ),
                      ),
                    SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print("Email: ${_emailController.text}");
                          print("Password: ${_passwordController.text}");
                          await loginProvider.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim());
                        }
                      },
                      height: 70,
                      minWidth:
                          loginProvider.isLoading ? null : double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: loginProvider.isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Iniciar Sesión",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿ No tienes una cuenta ?"),
                        SizedBox(width: 5),
                        TextButton(
                          onPressed: () => widget.toggleScreen(),
                          child: Text("Registrarse"),
                        )
                      ],
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
