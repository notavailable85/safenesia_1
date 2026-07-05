import 'package:flutter/material.dart';

class CustomDownloadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomDownloadButton({
    super.key,
    this.label = 'Download',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      icon: const Icon(Icons.download),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
