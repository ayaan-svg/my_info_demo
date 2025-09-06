import 'package:flutter/material.dart';
import 'data.dart'; // Import the data model

class EmergencyTab extends StatelessWidget {
  const EmergencyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: EmergencyContact.contacts.map((contact) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFF07E2E),
                  child: Text(
                    contact.name[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(contact.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.relationship),
                    Text(contact.phoneNumber),
                  ],
                ),
                trailing: const Icon(Icons.call, color: Color(0xFFF07E2E)),
                isThreeLine: true,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
