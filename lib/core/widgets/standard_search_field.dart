import 'package:flutter/material.dart';

class StandardSearchField extends StatelessWidget {
  final String hintText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const StandardSearchField({
    super.key,
    this.hintText = 'Cari...',
    this.autofocus = false,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white54, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white54, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white12,
          hintStyle: const TextStyle(color: Colors.white70),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.white70,
            size: 20,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
