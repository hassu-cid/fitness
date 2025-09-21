import 'package:flutter/material.dart';
import '../ui/adaptive.dart';
import '../ui/controls.dart';

class TargetWeightScreen extends StatefulWidget {
  static const routeName = '/target-weight';
  const TargetWeightScreen({super.key});

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  bool kg = true;
  double value = 80;

  @override
  Widget build(BuildContext context) {
    final valid = value > 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline("What's your target\nweight?"),
            const Spacer(),
            NumberStepper(value: value, min: 0, max: kg ? 300 : 660, onChanged: (v) => setState(() => value = v)),
            const SizedBox(height: 12),
            SegmentedTwo(
              left: 'kg',
              right: 'lbs',
              leftSelected: kg,
              onChanged: (left) => setState(() {
                if (kg != left) value = left ? value * 0.45359237 : value / 0.45359237;
                kg = left;
              }),
            ),
            const Spacer(),
            BottomPrimaryButton(
              label: 'Finish',
              onPressed: valid
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All set!')));
                Navigator.of(context).popUntil((r) => r.isFirst);
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
