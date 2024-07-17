import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';

class NavItem extends StatelessWidget {
  final IconData iconPath;

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              height: 3,
              width: 27,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const Gap(9),
            Icon(
              iconPath,
              color: isActive ? AppColors.primaryBlue : AppColors.grey,
              size: 28,
            ),
            const Gap(4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}
