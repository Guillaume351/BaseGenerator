import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:BaseGenerator/BaseGenerator.dart' as BaseGenerator;
import 'package:BaseGenerator/Objects/ImageHandler.dart';
import 'package:BaseGenerator/Objects/Matrix.dart';
import 'package:image/image.dart';

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

  LoadImages();
}

Future<void> LoadImages({String path = "assets/images/"}) async {
  DateTime timeBefore = DateTime.now();
  ImageHandler handler = ImageHandler();
  List files = await dirContents(Directory(path));
  List<Matrix> allImages = [];
  if (files is List) {
    files.forEach((f) {
      var image = decodeImage(f.readAsBytesSync());
      allImages.add(handler.ImageToMatrix(image));
    });
  } else {
    print("not files");
  }

  Matrix M = allImages[0].vectorize(); // first image
  //Then we add all the other images...
  allImages.getRange(1, allImages.length - 1).forEach((Matrix m) {
    M.addColumnVector(m.vectorize());
  });

  // Matrix autoCorr = M * M.transpose();
  Matrix smallAutoCorr = M.transpose() * M;

  List smallEigenValVect = smallAutoCorr.eigenValues(5);

  List<double> eigenValues = [];
  smallEigenValVect.forEach((e) => {eigenValues.add(e[0])});

  Matrix diag = Matrix(smallAutoCorr.getSize()[0], smallAutoCorr.getSize()[1]);

  eigenValues.forEach((double d) {
    diag.setData(
        eigenValues.indexOf(d), eigenValues.indexOf(d), pow(d, (-1 / 2)));
  });

  smallEigenValVect.forEach((e) {
    Matrix vect = M * (e[1].transpose() * diag).transpose();
    var min = vect.getMin();
    var max = vect.getMax();

    vect = (vect - Matrix.Ones(vect.getSize()[0], vect.getSize()[1]) * min) *
        (1 / (max - min));
    Image image =
    handler.MatrixToImage(vect.unVectorize(allImages[0].getSize()[0]));
    final filename = "output/" + e[0].toString() + ".png";
    new File(filename).writeAsBytesSync(encodePng(image));
  });

  print("Done ! Took : " + DateTime.now().difference(timeBefore).toString());
}

/// @return : Future<List<File>>
Future dirContents(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = new Completer();
  var lister = dir.list(recursive: false);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}
