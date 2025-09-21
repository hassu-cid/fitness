import 'package:flutter/material.dart';

enum FormFactor { phone, tablet, desktop }

FormFactor formFactorOf(BoxConstraints c) {
  final w = c.maxWidth;
  if (w >= 1024) return FormFactor.desktop;
  if (w >= 600) return FormFactor.tablet;
  return FormFactor.phone;
}

class CenteredBody extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const CenteredBody({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final ff = formFactorOf(c);
      final maxW = switch (ff) { FormFactor.phone => 480.0, FormFactor.tablet => 720.0, FormFactor.desktop => 840.0 };
      return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxW),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: child,
          ),
        ),
      );
    });
  }
}

class Headline extends StatelessWidget {
  final String text;
  const Headline(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final ff = formFactorOf(c);
      final size = switch (ff) { FormFactor.phone => 32.0, FormFactor.tablet => 40.0, FormFactor.desktop => 46.0 };
      return Text(text, style: TextStyle(fontSize: size, height: 1.15, fontWeight: FontWeight.w800, color: Colors.black));
    });
  }
}

class BottomPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const BottomPrimaryButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 8),
      child: SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: Text(label))),
    );
  }
}
