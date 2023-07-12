import 'package:flutter/material.dart';
import 'dart:math';

/// Dice Roller App using Stateful Widget
void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: const Text('Dice Roller'),
        backgroundColor: Colors.teal,
      ),
      body: Dice(),
    ),
  ));
}

class Dice extends StatefulWidget {

  // Stateful widget doesn't use build method but override "createState" method
  @override
  _DiceState createState() => _DiceState();
}

// _ indicates that this class is private & cannot be used by other class
class _DiceState extends State<Dice> {
  int dice_face = 1;

  void change_image() {

    // available by State function in flutter
    // to update UI
    setState(() {
      // Range through nextInt = 0...5
      // Add +1 to include 6
      dice_face = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: TextButton(
          child: Image.asset('images/dice_$dice_face.png'),
          onPressed: () {
            change_image();
          },
        ),
      ),
    );
  }
}
