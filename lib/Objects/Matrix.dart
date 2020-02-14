class Matrix {
  int _rows;
  int _columns;

  List<List> _values;

  Matrix(int rows, int columns, {int val = 0}) {
    _rows = rows;
    _columns = columns;
    _values = List.generate(rows, (_) => List.generate(columns, (_) => val));
  }



  Matrix ones(int rows, int columns){
    return Matrix(rows, columns, val: 1);
  }


  void setData(int row, int column, double data) {
    _values[row][column] = data;
  }

  double getData(int row, int column) {
    return _values[row][column];
  }

  /// return [rows, columns]
  List<int> getSize() {
    return [_rows, _columns];
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
    assert(getSize() == B.getSize());
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
    assert(getSize() == B.getSize());
    var sumMatrix = Matrix(_rows, _columns);
    for (var i = 0; i < _rows; i++) {
      for (var k = 0; k < _columns; k++) {
        sumMatrix.setData(i, k, getData(i, k) - B.getData(i, k));
      }
    }
    return sumMatrix;
  }

  /// :)
  Matrix operator *(var B) {
    var productMatrix;
    if (B is Matrix) {
      assert(_columns == B.getSize()[0]);
      productMatrix = Matrix(_rows, B.getSize()[1]);
      for (var i = 0; i < _rows; i++) {
        for (var j = 0; j < _columns; j++) {
          var smallSum = 0.0; // La petite sum
          for (var k = 0; k < _rows; k++) {
            smallSum += getData(i, k) * B.getData(k, j);
          }
          productMatrix.setData(i, j, smallSum);
        }
      }
    } else if (B is double || B is int) {
      productMatrix = Matrix(_rows, _columns);
      for (var i = 0; i < _rows; i++) {
        for (var j = 0; j < _columns; j++) {
          productMatrix.setData(i, j, B * getData(i, j));
        }
      }
    }
    return productMatrix;
  }
}
