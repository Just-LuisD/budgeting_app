import 'package:flutter/material.dart';

class AppInputTheme {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecorationTheme theme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      isDense: true,

      floatingLabelBehavior: FloatingLabelBehavior.always,
      //constraints: const BoxConstraints(maxWidth: 150),

      enabledBorder: _buildBorder(Colors.grey[600]!),
      errorBorder: _buildBorder(Colors.red),
      focusedErrorBorder: _buildBorder(Colors.red),
      focusedBorder: _buildBorder(Colors.grey[700]!),
      disabledBorder: _buildBorder(Colors.grey[400]!),
      //border: _buildBorder(Colors.black),

      suffixStyle: _buildTextStyle(Colors.black),
      counterStyle: _buildTextStyle(Colors.grey, size: 12.0),
      floatingLabelStyle: _buildTextStyle(Colors.black),
      errorStyle: _buildTextStyle(Colors.red, size: 12.0),
      helperStyle: _buildTextStyle(Colors.black, size: 12.0),
      hintStyle: _buildTextStyle(Colors.grey),
      labelStyle: _buildTextStyle(Colors.black),
      prefixStyle: _buildTextStyle(Colors.black),
    );
  }
}
