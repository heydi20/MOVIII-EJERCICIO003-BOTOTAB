// main.dart
import 'package:ejercicio_botontab/screens/Inventario.dart';
import 'package:ejercicio_botontab/screens/Producto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: InventarioScreen(),
  ));
}

class InventarioScreen extends StatefulWidget {
  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final inventario = Inventario();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  void _agregarProducto() {
    final nombre = _nombreController.text;
    final precio = double.tryParse(_precioController.text) ?? 0;
    final stock = int.tryParse(_stockController.text) ?? 0;

    if (nombre.isNotEmpty && precio > 0 && stock >= 0) {
      final nuevoProducto = Producto(nombre: nombre, precio: precio, stock: stock);
      setState(() {
        inventario.agregarProducto(nuevoProducto);
      });

      _nombreController.clear();
      _precioController.clear();
      _stockController.clear();
    }
  }

  void _actualizarStock(int index, int nuevoStock) {
    setState(() {
      inventario.productos[index].actualizarStock(nuevoStock);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventario de Productos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Formulario
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del producto'),
            ),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            TextField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Stock'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _agregarProducto,
              child: Text('Agregar producto'),
            ),
            Divider(),
            // Lista de productos
            Expanded(
              child: ListView.builder(
                itemCount: inventario.productos.length,
                itemBuilder: (context, index) {
                  final p = inventario.productos[index];
                  return ListTile(
                    title: Text(p.nombre),
                    subtitle: Text('Precio: \$${p.precio} - Stock: ${p.stock}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        final nuevoStockController = TextEditingController(text: p.stock.toString());
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Actualizar Stock'),
                            content: TextField(
                              controller: nuevoStockController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: 'Nuevo stock'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final nuevoStock = int.tryParse(nuevoStockController.text) ?? p.stock;
                                  _actualizarStock(index, nuevoStock);
                                  Navigator.pop(context);
                                },
                                child: Text('Actualizar'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Text(
              'Valor total del inventario: \$${inventario.calcularValorTotal().toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
