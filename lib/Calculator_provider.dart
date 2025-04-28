import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  String _input = '';
  String _result = '';
  String _history = '';

  String get input => _input;
  String get result => _result;
  String get history => _history;

  void addInput(String value) {
    if (value == 'C') {
      _input = '';
      _result = '';
    } else if (value == '⌫') {
      _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : '';
    } else if (value == '=') {
      try {
        final expression = _input
            .replaceAll('×', '*')
            .replaceAll('÷', '/')
            .replaceAll('π', 'pi')
            .replaceAll('e', '2.718281828459045');
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        _result = eval.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '');
        _history = '$_input = $_result\n$_history';
      } catch (e) {
        _result = 'Error';
      }
    } else {
      _input += value;
    }
    notifyListeners();
  }

  void toggleSign() {
    if (_input.isNotEmpty && _input[0] == '-') {
      _input = _input.substring(1);
    } else {
      _input = '-$_input';
    }
    notifyListeners();
  }
}