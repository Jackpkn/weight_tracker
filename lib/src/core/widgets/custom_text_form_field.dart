import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;

  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const ReusableTextFormField({
    super.key,
    required this.validator,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
