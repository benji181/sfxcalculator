import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfx_calculator_mobile/calculator_provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  static const List<String> buttons = [
    'C', '⌫', '(', ')', '÷',
    'sin', 'cos', 'tan', 'π', '×',
    '7', '8', '9', 'log', '-',
    '4', '5', '6', 'ln', '+',
    '1', '2', '3', '√', '^',
    '±', '0', '.', 'e', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        centerTitle: true,
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        provider.history,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        provider.input.isEmpty ? '0' : provider.input,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        provider.result,
                        style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    final button = buttons[index];
                    return ElevatedButton(
                      onPressed: () {
                        if (button == '±') {
                          provider.toggleSign();
                        } else {
                          provider.addInput(button);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getButtonColor(button),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        button,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (['C', '⌫', '='].contains(button)) {
      return Colors.red;
    } else if (['sin', 'cos', 'tan', 'log', 'ln', '√', '^', 'π', 'e', '(', ')', '±'].contains(button)) {
      return Colors.blue;
    } else if (['÷', '×', '-', '+'].contains(button)) {
      return Colors.orange;
    } else {
      return Colors.grey[800]!;
    }
  }
}