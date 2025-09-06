import 'package:flutter/material.dart';

class TrainingTab extends StatelessWidget {
  const TrainingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Training courses and status',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}
