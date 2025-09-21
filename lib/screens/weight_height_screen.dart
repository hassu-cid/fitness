import 'dart:math' as math;
import 'package:flutter/material.dart';

class WeightHeightScreen extends StatefulWidget {
  static const routeName = '/weightHeight';
  const WeightHeightScreen({super.key});

  @override
  State<WeightHeightScreen> createState() => _WeightHeightScreenState();
}

class _WeightHeightScreenState extends State<WeightHeightScreen> {
  double _weight = 70;
  double _height = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight & Height'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Select your weight (kg)', style: TextStyle(fontSize: 22)),
            Slider(
              value: _weight,
              min: 30,
              max: 180,
              divisions: 150,
              label: _weight.round().toString(),
              onChanged: (v) => setState(() => _weight = v),
            ),
            Text('${_weight.round()} kg', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            const Text('Select your height (cm)', style: TextStyle(fontSize: 22)),
            Slider(
              value: _height,
              min: 140,
              max: 210,
              divisions: 70,
              label: _height.round().toString(),
              onChanged: (v) => setState(() => _height = v),
            ),
            Text('${_height.round()} cm', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/targetWeight');
              },
              child: const Text('Continue'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}