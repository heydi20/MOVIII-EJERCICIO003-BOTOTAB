import 'package:ejercicio_botontab/screens/Estudiante.dart';
import 'package:ejercicio_botontab/screens/materia.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: MateriaScreen(),
  ));
}

class MateriaScreen extends StatefulWidget {
  @override
  State<MateriaScreen> createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  final estudiante = Estudiante();
  final TextEditingController _nombreMateriaController = TextEditingController();

  void _agregarMateria() {
    final nombre = _nombreMateriaController.text;
    if (nombre.isNotEmpty) {
      setState(() {
        estudiante.agregarMateria(Materia(nombre));
        _nombreMateriaController.clear();
      });
    }
  }

  void _agregarNotaDialog(Materia materia) {
    final notaController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Agregar nota a ${materia.nombre}'),
        content: TextField(
          controller: notaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Nota (0 - 10)'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final nota = double.tryParse(notaController.text);
              if (nota != null && nota >= 0 && nota <= 10) {
                setState(() {
                  materia.agregarNota(nota);
                });
              }
              Navigator.pop(context);
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final promedioGeneral = estudiante.promedioGeneral().toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Materias')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulario para nueva materia
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nombreMateriaController,
                    decoration: InputDecoration(labelText: 'Nombre de la materia'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _agregarMateria,
                  child: Text('Agregar'),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Lista de materias
            Expanded(
              child: ListView.builder(
                itemCount: estudiante.materias.length,
                itemBuilder: (context, index) {
                  final materia = estudiante.materias[index];
                  return ListTile(
                    title: Text(materia.nombre),
                    subtitle: Text('Promedio: ${materia.calcularPromedio().toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _agregarNotaDialog(materia),
                    ),
                  );
                },
              ),
            ),

            // Promedio general
            Text(
              'Promedio general del estudiante: $promedioGeneral',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
