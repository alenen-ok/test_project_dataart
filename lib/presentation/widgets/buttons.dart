import 'package:flutter/material.dart';
import 'package:test_project/core/constants/colors.dart';

class DefaultFilledButton extends StatelessWidget {
  const DefaultFilledButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: onTap == null ? AppColors.coolGray : AppColors.deepBlue,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.white, fontSize: 20.0, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
