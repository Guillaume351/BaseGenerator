import 'package:BaseGenerator/BaseGenerator.dart' as BaseGenerator;
import 'package:BaseGenerator/Objects/Matrix.dart';

void main(List<String> arguments) {
  print('Hello world: ${BaseGenerator.calculate()}!');
  var superMatrix = Matrix(1, 3);

  superMatrix.setData(0, 0, 2);
  superMatrix.setData(0, 1, 1);
  superMatrix.setData(0, 2, 2);

  var superMegaDiagonaleDesFamilles = Matrix.Diag(superMatrix);
  print(superMegaDiagonaleDesFamilles);
  superMegaDiagonaleDesFamilles =
      superMegaDiagonaleDesFamilles - superMatrix.transpose();
  print(superMegaDiagonaleDesFamilles);

}
