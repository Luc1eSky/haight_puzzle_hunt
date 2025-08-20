import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onValidNumber;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.onValidNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          _UsNumberTextInputFormatter(),
        ],
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          hintText: '(123) 456-7890',
          labelStyle: TextStyle(fontFamily: 'RockSalt', color: Colors.black),
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(fontFamily: 'RockSalt', color: Colors.black),
        onChanged: (value) {
          final digits = value.replaceAll(RegExp(r'[^\d]'), '');
          if (digits.length == 10) {
            onValidNumber('+1$digits');
          } else {
            onValidNumber('');
          }
        },
      ),
    );
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 0) buffer.write('(');
      if (i == 3) buffer.write(') ');
      if (i == 6) buffer.write('-');
      if (i >= 10) break;
      buffer.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
