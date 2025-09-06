import 'package:flutter/material.dart';
import 'personal_tab.dart';
import 'job_tab.dart';
import 'time_off_tab.dart';
import 'performance.dart';
import 'emergency_tab.dart';
import 'benefits.dart';
import 'documents_tab.dart';
import 'training_tab.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'My Info',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFFF07E2E),
            labelColor: Color(0xFFF07E2E),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'Job'),
              Tab(text: 'Time Off'),
              Tab(text: 'Performance'),
              Tab(text: 'Emergency'),
              Tab(text: 'Benefits'),
              Tab(text: 'Documents'),
              Tab(text: 'Training'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PersonalTab(),
            JobTab(),
            TimeOffTab(),
            PerformanceTab(),
            EmergencyTab(),
            BenefitsTab(),
            DocumentsTab(),
            TrainingTab(),
          ],
        ),
      ),
    );
  }
}
