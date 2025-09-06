import 'package:flutter/material.dart';
import 'data.dart'; // Import the data model

class BenefitsTab extends StatelessWidget {
  const BenefitsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Current Benefits',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ...BenefitPlan.plans.map((plan) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    plan.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(plan.coverage),
                  trailing: Text(
                    plan.status,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
