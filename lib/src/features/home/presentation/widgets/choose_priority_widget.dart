import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constant/colors.dart';

class ChoosePriority extends StatelessWidget {
  const ChoosePriority({
    super.key,
    required this.selectedPriority,
    required this.taskPriority,
  });

  final ValueNotifier<String?> selectedPriority;
  final List<String> taskPriority;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Task Priority',
          style: TextStyle(
            color: Color(0xFF484848),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (selectedPriority.value == null) {
                    selectedPriority.value = taskPriority[index];
                  } else if (selectedPriority.value == taskPriority[index]) {
                    selectedPriority.value = null;
                  } else {
                    selectedPriority.value = taskPriority[index];
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selectedPriority.value == taskPriority[index]
                        ? AppColors.primaryGreen
                        : Colors.white,
                    border: Border.all(
                      color: selectedPriority.value == taskPriority[index]
                          ? AppColors.primaryGreen
                          : AppColors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      taskPriority[index],
                      style: TextStyle(
                        color: selectedPriority.value == taskPriority[index]
                            ? Colors.white
                            : AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
