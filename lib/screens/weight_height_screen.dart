import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'target_weight_screen.dart'; // ✅ Import TargetWeightScreen

class WeightHeightScreen extends StatefulWidget {
  static const routeName = '/weightHeight';
  const WeightHeightScreen({super.key});

  @override
  State<WeightHeightScreen> createState() => _WeightHeightScreenState();
}

class _WeightHeightScreenState extends State<WeightHeightScreen> {
  bool isKg = true; // ✅ Start with kg
  bool isCm = true; // ✅ Start with cm

  double weightKg = 74.8; // internal metric storage
  double heightCm = 175;

  final double minKg = 30;
  final double maxKg = 200;
  final double minCm = 120;
  final double maxCm = 230;

  double get weightDisplay => isKg ? weightKg : weightKg * 2.2046226218;
  int get feet => (heightCm / 30.48).floor();
  int get inches => ((heightCm / 2.54).round() - feet * 12);

  void setWeightFromDisplay(double value) {
    setState(() {
      weightKg = isKg ? value : value / 2.2046226218;
    });
  }

  void setHeightFromCm(double cm) {
    setState(() {
      heightCm = cm.clamp(minCm, maxCm);
    });
  }

  void setHeightFromFeetInch(double ftValue) {
    final ft = ftValue.floor();
    final inch = ((ftValue - ft) * 12).round();
    final cm = (ft * 12 + inch) * 2.54;
    setState(() {
      heightCm = cm.clamp(minCm, maxCm);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top progress bar + Skip
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      color: const Color(0xFFFF2F2F),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Skip to TargetWeightScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TargetWeightScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Title + subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Let us know you better',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let us know you better to help boost your\nworkout results',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Weight
                    Text(
                      'Weight',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _BigNumber(
                      value: isKg
                          ? weightKg.toStringAsFixed(1)
                          : weightDisplay.toStringAsFixed(1),
                      suffix: isKg ? 'kg' : 'lbs',
                      color: const Color(0xFF1660FF),
                    ),
                    const SizedBox(height: 12),
                    _SegmentedSwitch(
                      left: 'kg',
                      right: 'lbs',
                      isRight: !isKg,
                      onChanged: (right) {
                        setState(() => isKg = !right ? true : false);
                      },
                    ),
                    const SizedBox(height: 12),
                    _Ruler(
                      min: isKg ? minKg : minKg * 2.2046226218,
                      max: isKg ? maxKg : maxKg * 2.2046226218,
                      value: weightDisplay,
                      onChanged: setWeightFromDisplay,
                      majorStep: 1,
                      minorTick: 10,
                      visibleMajorCount: 5,
                    ),

                    const SizedBox(height: 28),

                    // Height
                    Text(
                      'Height',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    isCm
                        ? _BigNumber(
                      value: heightCm.round().toString(),
                      suffix: 'cm',
                      color: const Color(0xFF1660FF),
                    )
                        : _BigFeetInch(
                      feet: feet,
                      inch: inches,
                      color: const Color(0xFF1660FF),
                    ),
                    const SizedBox(height: 12),
                    _SegmentedSwitch(
                      left: 'cm',
                      right: 'ft',
                      isRight: !isCm,
                      onChanged: (right) {
                        setState(() => isCm = !right ? true : false);
                      },
                    ),
                    const SizedBox(height: 12),
                    if (isCm)
                      _Ruler(
                        min: minCm,
                        max: maxCm,
                        value: heightCm,
                        onChanged: setHeightFromCm,
                        majorStep: 10,
                        minorTick: 10,
                        visibleMajorCount: 5,
                      )
                    else
                      _Ruler(
                        min: 4.0,
                        max: 7.9,
                        value: heightCm / 30.48,
                        onChanged: setHeightFromFeetInch,
                        majorStep: 1,
                        minorTick: 12,
                        visibleMajorCount: 5,
                      ),

                    SizedBox(height: width > 400 ? 40 : 28),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            SafeArea(
              top: false,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to TargetWeightScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TargetWeightScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF44336),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

/* ---------- UI PARTS ---------- */

class _SegmentedSwitch extends StatelessWidget {
  final String left;
  final String right;
  final bool isRight;
  final ValueChanged<bool> onChanged;
  const _SegmentedSwitch({
    required this.left,
    required this.right,
    required this.isRight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segButton(
              label: left, selected: !isRight, onTap: () => onChanged(false)),
          _segButton(
              label: right, selected: isRight, onTap: () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _segButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1660FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _BigNumber extends StatelessWidget {
  final String value;
  final String suffix;
  final Color color;
  const _BigNumber({
    required this.value,
    required this.suffix,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          suffix,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _BigFeetInch extends StatelessWidget {
  final int feet;
  final int inch;
  final Color color;
  const _BigFeetInch({
    required this.feet,
    required this.inch,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$feet',
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'ft',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$inch',
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'in',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _Ruler extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final double majorStep;
  final int minorTick;
  final ValueChanged<double> onChanged;
  final int visibleMajorCount;

  const _Ruler({
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.majorStep,
    required this.minorTick,
    this.visibleMajorCount = 5,
  });

  @override
  State<_Ruler> createState() => _RulerState();
}

class _RulerState extends State<_Ruler> {
  void _updateValueFromGlobalX(double dx, double width) {
    final windowUnits = (widget.visibleMajorCount - 1) * widget.majorStep;
    final pxPerUnit = windowUnits > 0 ? (width / windowUnits) : width;
    final centerX = width / 2;
    double newValue = widget.value + (dx - centerX) / pxPerUnit;
    final double step = widget.majorStep / widget.minorTick;
    if (step > 0) {
      newValue = (newValue / step).round() * step;
    }
    newValue = newValue.clamp(widget.min, widget.max);
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (details) {
            final local = details.localPosition.dx;
            _updateValueFromGlobalX(local, constraints.maxWidth);
          },
          onHorizontalDragUpdate: (details) {
            final local = details.localPosition.dx;
            _updateValueFromGlobalX(local, constraints.maxWidth);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _WindowedTicksPainter(
                    min: widget.min,
                    max: widget.max,
                    value: widget.value,
                    majorStep: widget.majorStep,
                    minorTick: widget.minorTick,
                    visibleMajorCount: widget.visibleMajorCount,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: Container(width: 2, color: const Color(0xFF1660FF)),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _WindowedTicksPainter extends CustomPainter {
  final double min;
  final double max;
  final double value;
  final double majorStep;
  final int minorTick;
  final int visibleMajorCount;

  _WindowedTicksPainter({
    required this.min,
    required this.max,
    required this.value,
    required this.majorStep,
    required this.minorTick,
    required this.visibleMajorCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintMajor = Paint()
      ..color = Colors.black.withOpacity(0.45)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final paintMinor = Paint()
      ..color = Colors.black.withOpacity(0.25)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final baselineY = size.height * 0.25;
    final majorTickHeight = size.height * 0.35;
    final minorTickHeight = size.height * 0.20;

    final windowUnits = (visibleMajorCount - 1) * majorStep;
    final pxPerUnit = windowUnits > 0 ? (size.width / windowUnits) : size.width;

    double halfWindow = (visibleMajorCount - 1) / 2;
    double startMajor = value - halfWindow * majorStep;

    if (startMajor < min) startMajor = min;
    if (startMajor + windowUnits > max) {
      startMajor = (max - windowUnits).clamp(min, max);
    }

    final basePaint = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, baselineY), Offset(size.width, baselineY), basePaint);

    for (int i = 0; i < visibleMajorCount; i++) {
      final double majorValue = startMajor + i * majorStep;
      final double x = centerX + (majorValue - value) * pxPerUnit;
      if (x < -50 || x > size.width + 50) continue;

      canvas.drawLine(
          Offset(x, baselineY), Offset(x, baselineY + majorTickHeight), paintMajor);

      final tp = TextPainter(
        text: TextSpan(
          text: majorValue.round().toString(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final labelX = x - tp.width / 2;
      final labelY = baselineY + majorTickHeight + 4;
      tp.paint(canvas, Offset(labelX, labelY));

      if (i < visibleMajorCount - 1) {
        for (int s = 1; s < minorTick; s++) {
          final double subValue = majorValue + s * (majorStep / minorTick);
          final double sx = centerX + (subValue - value) * pxPerUnit;
          if (sx < -20 || sx > size.width + 20) continue;
          canvas.drawLine(
              Offset(sx, baselineY), Offset(sx, baselineY + minorTickHeight), paintMinor);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WindowedTicksPainter old) {
    return old.value != value ||
        old.min != min ||
        old.max != max ||
        old.majorStep != majorStep ||
        old.minorTick != minorTick ||
        old.visibleMajorCount != visibleMajorCount;
  }
}
