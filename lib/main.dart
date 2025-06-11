import 'package:ejercicio_botontab/screens/Pantalla1Screen.dart';
import 'package:ejercicio_botontab/screens/Pantalla2Screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Ejercicios03App());
}

class Ejercicios03App extends StatelessWidget {
  const Ejercicios03App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  int indice=0;
  List<Widget> paginas=[BibliotecaScreen(),MateriaScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NAVEGACIÓN"),),
      body: paginas[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,

        onTap: (value) {
          setState(() {
            indice=value;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.filter_1_outlined),label: "PANTALLA 1"),
        BottomNavigationBarItem(icon: Icon(Icons.filter_2_outlined),label: "PANTALLA 2"),
      ]),
    );
  }
}