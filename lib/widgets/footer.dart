import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.g_mobiledata, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.play_circle, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.message, size: 30),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}