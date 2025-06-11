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

  @override
  String toString() {
    return 'Título: $titulo\nAutor: $autor\nAño: $anioPublicacion\nDisponible: $cantidadDisponible';
  }
}
