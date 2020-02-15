import 'package:image/image.dart';

import 'Matrix.dart';
import 'Matrix.dart';

class ImageHandler {
  Matrix ImageToMatrix(Image image) {
    Matrix imageMatrix = Matrix(image.height, image.width);
    for (int i = 0; i < image.height; i++) {
      for (int j = 0; j < image.width; j++) {
        imageMatrix.setData(i, j, BlackAndWhiteConverter(image.getPixel(i, j)));
      }
    }
    return imageMatrix;
  }

  Image MatrixToImage(Matrix matrix) {
    Image image = Image(matrix.getSize()[0], matrix.getSize()[1]);
    for (int i = 0; i < image.width; i++) {
      for (int j = 0; j < image.height; j++) {
        int color = matrix.getData(i, j) .round();
        image.setPixel(i, j, Color.fromRgb(color, color, color));
      }
    }
    return image;
  }

  double BlackAndWhiteConverter(int allColors) {
    return (getRed(allColors) + getGreen(allColors) + getBlue(allColors)) / 3;
  }

  void SaveImage(Image image) {}
}
