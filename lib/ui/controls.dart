import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;
  final double? centerWidth; // allows shrinking on tight screens

  const NumberStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 300,
    this.step = 1,
    this.centerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final w = c.maxWidth;
      final numSize = w < 320 ? 56.0 : w < 360 ? 64.0 : w < 600 ? 88.0 : 104.0;
      final midWidth = centerWidth ??
          (w < 320
              ? 110.0
              : w < 360
              ? 130.0
              : 160.0);

      return Row(
        mainAxisSize: MainAxisSize.min, // shrink to fit
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _circleBtn(context, Icons.remove, () => onChanged((value - step).clamp(min, max))),
          const SizedBox(width: 16),
          SizedBox(
            width: midWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value.truncateToDouble() == value ? value.toStringAsFixed(0) : value.toStringAsFixed(1),
                style: TextStyle(fontSize: numSize, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _circleBtn(context, Icons.add, () => onChanged((value + step).clamp(min, max))),
        ],
      );
    });
  }

  Widget _circleBtn(BuildContext context, IconData icon, VoidCallback onTap) {
    return InkResponse(
      onTap: onTap,
      radius: 36,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Icon(icon, size: 28, color: Colors.black87),
      ),
    );
  }
}

class SegmentedTwo extends StatelessWidget {
  final String left;
  final String right;
  final bool leftSelected;
  final ValueChanged<bool> onChanged;
  const SegmentedTwo({super.key, required this.left, required this.right, required this.leftSelected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF2F3F6), borderRadius: BorderRadius.circular(28)),
      padding: const EdgeInsets.all(4),
      child: Row(children: [
        _seg(context, left, leftSelected, () => onChanged(true)),
        _seg(context, right, !leftSelected, () => onChanged(false)),
      ]),
    );
  }

  Widget _seg(BuildContext context, String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: selected ? const Color(0xFF2F68FF) : Colors.transparent, borderRadius: BorderRadius.circular(24)),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
