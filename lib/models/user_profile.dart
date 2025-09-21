class UserProfile {
  String goal = '';
  int? age;
  double? weightKg;
  double? heightCm;
  double? targetWeightKg;

  bool get hasHeight => (heightCm ?? 0) > 0;
  double? get bmi {
    if (!hasHeight || (weightKg ?? 0) <= 0) return null;
    final m = heightCm! / 100.0;
    return weightKg! / (m * m);
  }
}
