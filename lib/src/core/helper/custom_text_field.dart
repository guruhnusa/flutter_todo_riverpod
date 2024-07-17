import 'package:flutter/material.dart';
import 'package:sabani_tech_test/src/core/utils/constant/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Color filled;
  final Color textColor;
  final Color labelColor;
  final bool isBorder;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool isRequired;
  final String? Function(String?)? validator;

  final VoidCallback? suffixOnPressed;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.filled = Colors.transparent,
    this.textColor = Colors.black,
    this.labelColor = AppColors.grey,
    this.isBorder = true,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
    this.onChanged,
    this.obscureText = false,
    this.isRequired = false,
    this.validator,
    this.suffixOnPressed,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isBorder ? AppColors.grey : Colors.transparent,
        ),
        color: widget.filled,
      ),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.isReadOnly,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        validator: widget.validator,
        obscureText: widget.obscureText ? isPassword : false,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: isPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(
                      () {
                        isPassword = !isPassword;
                      },
                    );
                  },
                )
              : null,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          label: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widget.isRequired
                  ? const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.only(bottom: widget.obscureText ? 5 : 5, top: 5),
          filled: true,
          fillColor: widget.filled,
        ),
      ),
    );
  }
}
