import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final void Function(String?)? onSaved;
  final TextEditingController controller;
  const ReusableTextFormField({
    super.key,
    required this.validator,
    required this.controller,
    required this.onSaved,
    this.labelText = '',
    this.hintText = '',
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
