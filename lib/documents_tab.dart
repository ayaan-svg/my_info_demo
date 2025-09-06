import 'package:flutter/material.dart';
import 'data.dart'; // Import the data model

class DocumentsTab extends StatelessWidget {
  const DocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: Document.documents.map((doc) {
                  return ListTile(
                    leading: Icon(doc.icon, color: const Color(0xFFF07E2E)),
                    title: Text(doc.name),
                    subtitle: Text(doc.date),
                    trailing: const Icon(Icons.chevron_right),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
