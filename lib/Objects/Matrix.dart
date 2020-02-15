import 'dart:math';

class Matrix {
  int _rows;
  int _columns;

  List<List<double>> _values;

  Matrix(int rows, int columns, {double val = 0.0}) {
    _rows = rows;
    _columns = columns;
    _values = List.generate(rows, (_) => List.generate(columns, (_) => val));
  }

  Matrix.Ones(int rows, int columns) : this(rows, columns, val: 1);

  Matrix.Diag(Matrix vector) {
    assert(vector.getSize()[0] == 1 || vector.getSize()[1] == 1);

    if (vector.getSize()[0] > 1) {
      vector = vector.transpose();
    }
    _rows = vector.getSize()[1];
    _columns = _rows;
    _values = List.generate(
        vector.getSize()[1],
            (int i) =>
            List.generate(vector.getSize()[1],
                    (int j) => i == j ? vector.getData(0, i) : 0));
  }

  Matrix.Random(int rows, int columns) {
    _rows = rows;
    _columns = columns;
    _values = List.generate(
        rows, (_) => List.generate(columns, (_) => Random().nextDouble()));
  }

  void setData(int row, int column, double data) {
    _values[row][column] = data;
  }

  double getData(int row, int column) {
    return _values[row][column];
  }


  double getNorm() {
    var norm = 0.0;
    for (var i = 0; i < _rows; i++) {
      for (var k = 0; k < _columns; k++) {
        norm += pow(getData(i, k), 2);
      }
    }
    return sqrt(norm);
  }

  List eigenValues() {

  }

  /// return [rows, columns]
  List<int> getSize() {
    return [_rows, _columns];
  }

  double toDouble() {
    return getData(1, 1);
  }

  @override
  String toString() {
    var matrixText = '';
    for (var i = 0; i < _rows; i++) {
      for (var k = 0; k < _columns; k++) {
        matrixText += ' ' + _values[i][k].toString() + ' ';
      }
      matrixText += '\n';
    }
    return matrixText;
  }

  /// :'''')
  Matrix transpose() {
    var transposedMatrix = Matrix(_columns, _rows);
    for (var i = 0; i < _rows; i++) {
      for (var k = 0; k < _columns; k++) {
        transposedMatrix.setData(k, i, getData(i, k));
      }
    }
    return transposedMatrix;
  }

  /// xD
  Matrix operator +(Matrix B) {
    assert(getSize()[0] == B.getSize()[0] && getSize()[1] == B.getSize()[1]);
    var sumMatrix = Matrix(_rows, _columns);
    for (var i = 0; i < _rows; i++) {
      for (var k = 0; k < _columns; k++) {
        sumMatrix.setData(i, k, getData(i, k) + B.getData(i, k));
      }
    }
    return sumMatrix;
  }

  /// :'(
  Matrix operator -(Matrix B) {
    var sumMatrix = Matrix(_rows, _columns);
    if ((getSize()[0] == B.getSize()[0] && getSize()[1] == B.getSize()[1])) {
      for (var i = 0; i < _rows; i++) {
        for (var k = 0; k < _columns; k++) {
          sumMatrix.setData(i, k, getData(i, k) - B.getData(i, k));
        }
      }
    } else if (B.getSize()[0] == 1 && B.getSize()[1] == _columns) {
      for (var i = 0; i < _rows; i++) {
        for (var k = 0; k < _columns; k++) {
          sumMatrix.setData(i, k, getData(i, k) - B.getData(0, k));
        }
      }
    } else if (B.getSize()[0] == _rows && B.getSize()[1] == 1) {
      for (var i = 0; i < _rows; i++) {
        for (var k = 0; k < _columns; k++) {
          sumMatrix.setData(i, k, getData(i, k) - B.getData(i, 0));
        }
      }
    }

    return sumMatrix;
  }

  /// :)
  Matrix operator *(var m2) {
    var productMatrix;
    if (m2 is Matrix) {
      assert(_columns == m2.getSize()[0]);
      productMatrix = Matrix(_rows, m2.getSize()[1]);
      for (var i = 0; i < _rows; i++) {
        for (var j = 0; j < _columns; j++) {
          var smallSum = 0.0; // La petite sum
          for (var k = 0; k < _rows; k++) {
            smallSum += getData(i, k) * m2.getData(k, j);
          }
          productMatrix.setData(i, j, smallSum);
        }
      }
    } else if (m2 is double || m2 is int) {
      productMatrix = Matrix(_rows, _columns);
      for (var i = 0; i < _rows; i++) {
        for (var j = 0; j < _columns; j++) {
          productMatrix.setData(i, j, m2 * getData(i, j));
        }
      }
    }
    return productMatrix;
  }
}
