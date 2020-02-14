import 'package:BaseGenerator/BaseGenerator.dart' as BaseGenerator;
import 'package:BaseGenerator/Objects/Matrix.dart';

void main(List<String> arguments) {
  print('Hello world: ${BaseGenerator.calculate()}!');
  var superMatrix = Matrix(2, 3);

  superMatrix.setData(0, 0, 2);
  superMatrix.setData(0, 1, 1);
  superMatrix.setData(0, 2, 2);
  superMatrix.setData(1, 0, 2);
  superMatrix.setData(1, 1, 2);
  superMatrix.setData(1, 2, 7);

  print(superMatrix);

}
