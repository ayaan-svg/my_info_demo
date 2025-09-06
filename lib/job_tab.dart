import 'package:flutter/material.dart';
import 'data.dart'; // Import the data model

class JobTab extends StatelessWidget {
  const JobTab({super.key});

  @override
  Widget build(BuildContext context) {
    final jobInfo = JobInfo.jakeBryanJob;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSection('Job Information', [
            _buildInfoRow(label: 'Job Title', value: jobInfo.jobTitle),
            _buildInfoRow(label: 'Department', value: jobInfo.department),
            _buildInfoRow(label: 'Reports To', value: jobInfo.reportsTo),
            _buildInfoRow(
              label: 'Employment Status',
              value: jobInfo.employmentStatus,
            ),
            _buildInfoRow(label: 'Hire Date', value: jobInfo.hireDate),
          ]),
          _buildSection('Compensation', [
            _buildInfoRow(label: 'Compensation', value: jobInfo.compensation),
            _buildInfoRow(label: 'Hourly Rate', value: jobInfo.hourlyRate),
            _buildInfoRow(label: 'Pay Schedule', value: jobInfo.paySchedule),
            _buildInfoRow(label: 'Last Raise', value: jobInfo.lastRaise),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
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
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
