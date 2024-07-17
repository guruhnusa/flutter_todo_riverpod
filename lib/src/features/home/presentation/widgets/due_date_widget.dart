import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sabani_tech_test/src/core/extensions/string_context_ext.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';

class DueDataTextField extends StatelessWidget {
  const DueDataTextField({
    super.key,
    required this.dateinput,
  });

  final ValueNotifier<String?> dateinput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Due date ',
          style: TextStyle(
            color: Color(0xFF484848),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: () async {
            DateTime today = DateTime.now();

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: today,
              firstDate: today,
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              dateinput.value = DateFormat('yyyy-MM-dd').format(pickedDate);
            }
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      dateinput.value == null
                          ? 'DD  /  MM/  YY'
                          : dateinput.value!.formatDate(),
                      style: const TextStyle(
                        color: Color(0xFF777373),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    dateinput.value == null
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              dateinput.value = null;
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: AppColors.primaryRed,
                            ),
                          ),
                  ],
                ),
              ),
              const Gap(16),
              const Icon(
                Icons.calendar_today,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
