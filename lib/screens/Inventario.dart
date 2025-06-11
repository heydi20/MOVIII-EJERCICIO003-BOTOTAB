import 'package:ejercicio_botontab/screens/Pantalla2Screen.dart';
import 'package:ejercicio_botontab/screens/Producto.dart';

class Inventario {
  List<Producto> productos = [];

  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  double calcularValorTotal() {
    return productos.fold(0, (suma, p) => suma + p.valorTotal());
  }

  List<String> mostrarInfoProductos() {
    return productos.map((p) => p.info()).toList();
  }
}