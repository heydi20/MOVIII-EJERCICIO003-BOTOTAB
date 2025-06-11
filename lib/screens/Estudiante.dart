import 'materia.dart';

class Estudiante {
  List<Materia> materias = [];

  void agregarMateria(Materia materia) {
    materias.add(materia);
  }

  double promedioGeneral() {
    if (materias.isEmpty) return 0.0;
    double suma = materias.fold(0.0, (total, m) => total + m.calcularPromedio());
    return suma / materias.length;
  }
}
