// models/producto.dart
class Producto {
  String nombre;
  double precio;
  int stock;

  Producto({required this.nombre, required this.precio, required this.stock});

  void actualizarStock(int cantidad) {
    stock = cantidad;
  }

  double valorTotal() => precio * stock;

  String info() => '$nombre - \$${precio.toStringAsFixed(2)} x $stock';
}
