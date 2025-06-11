class Materia {
  String nombre;
  List<double> notas;

  Materia(this.nombre) : notas = [];

  // Agrega una nota a la lista
  void agregarNota(double nota) {
    if (nota >= 0 && nota <= 10) {
      notas.add(nota);
    } else {
      throw ArgumentError('La nota debe estar entre 0 y 10');
    }
  }

  // Calcula el promedio de las notas
  double calcularPromedio() {
    if (notas.isEmpty) return 0.0;
    double suma = notas.reduce((a, b) => a + b);
    return suma / notas.length;
  }

  // Devuelve información de la materia
  String mostrarInformacion() {
    return 'Materia: $nombre - Promedio: ${calcularPromedio().toStringAsFixed(2)}';
  }
}
