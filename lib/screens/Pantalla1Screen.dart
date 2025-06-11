import 'package:flutter/material.dart';

class Libro {
  String titulo;
  String autor;
  int anioPublicacion;
  int cantidadDisponible;

  Libro({
    required this.titulo,
    required this.autor,
    required this.anioPublicacion,
    required this.cantidadDisponible,
  });
}

class BibliotecaScreen extends StatefulWidget {
  const BibliotecaScreen({Key? key}) : super(key: key);

  @override
  _BibliotecaScreenState createState() => _BibliotecaScreenState();
}

class _BibliotecaScreenState extends State<BibliotecaScreen> {
  List<Libro> biblioteca = [];

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _anioController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _buscarController = TextEditingController();

  List<Libro> resultadosBusqueda = [];

  void agregarLibro() {
    if (_tituloController.text.isEmpty ||
        _autorController.text.isEmpty ||
        _anioController.text.isEmpty ||
        _cantidadController.text.isEmpty) {
      return;
    }

    setState(() {
      biblioteca.add(Libro(
        titulo: _tituloController.text,
        autor: _autorController.text,
        anioPublicacion: int.parse(_anioController.text),
        cantidadDisponible: int.parse(_cantidadController.text),
      ));

      _tituloController.clear();
      _autorController.clear();
      _anioController.clear();
      _cantidadController.clear();
    });
  }

  void buscarLibro() {
    setState(() {
      resultadosBusqueda = biblioteca
          .where((libro) => libro.titulo
              .toLowerCase()
              .contains(_buscarController.text.toLowerCase()))
          .toList();

      if (resultadosBusqueda.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:  Text("Aviso"),
            content:  Text("No se encontraron libros con ese título."),
            actions: [
              TextButton(
                child:  Text("Aceptar"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      }
    });
  }

  void limpiarBusqueda() {
    setState(() {
      _buscarController.clear();
      resultadosBusqueda.clear();
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _anioController.dispose();
    _cantidadController.dispose();
    _buscarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Libro> listaParaMostrar =
        resultadosBusqueda.isNotEmpty || _buscarController.text.isNotEmpty
            ? resultadosBusqueda
            : biblioteca;

    return Scaffold(
      appBar: AppBar(title:  Text('Biblioteca')),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [
             Text(
              "Agregar libro",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _tituloController,
              decoration:  InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _autorController,
              decoration:  InputDecoration(labelText: 'Autor'),
            ),
            TextField(
              controller: _anioController,
              decoration:  InputDecoration(labelText: 'Año de publicación'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cantidadController,
              decoration:  InputDecoration(labelText: 'Cantidad disponible'),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 10),
            ElevatedButton(
              onPressed: agregarLibro,
              child:  Text('Agregar'),
            ),
             Divider(height: 40),
             Text(
              "Buscar libro por título",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _buscarController,
              decoration:  InputDecoration(labelText: 'Título a buscar'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: buscarLibro,
                  child:  Text('Buscar'),
                ),
                ElevatedButton(
                  onPressed: limpiarBusqueda,
                  child:  Text('Limpiar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
              ],
            ),
             SizedBox(height: 20),
             Text(
              "Libros en la biblioteca",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listaParaMostrar.length,
              itemBuilder: (context, index) {
                final libro = listaParaMostrar[index];
                return ListTile(
                  title: Text(libro.titulo),
                  subtitle: Text(
                      'Autor: ${libro.autor} - Año: ${libro.anioPublicacion} - Cantidad: ${libro.cantidadDisponible}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
