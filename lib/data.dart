// Placeholder for a profile picture.
import 'package:flutter/material.dart';

const String profilePicturePath = 'assets/profile.png';

class UserInfo {
  int? id;
  String firstName;
  String lastName;
  String middleName;
  String preferredName;
  String fullName;
  String jobTitle;
  String profilePicture;
  String workPhone;
  String mobilePhone;
  String workEmail;
  String gender;
  String dateOfBirth;
  String maritalStatus;
  String addressLine1;
  String city;
  String state;
  String zipCode;

  UserInfo({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.preferredName,
    required this.fullName,
    required this.jobTitle,
    required this.profilePicture,
    required this.workPhone,
    required this.mobilePhone,
    required this.workEmail,
    required this.gender,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'preferredName': preferredName,
      'fullName': fullName,
      'jobTitle': jobTitle,
      'profilePicture': profilePicture,
      'workPhone': workPhone,
      'mobilePhone': mobilePhone,
      'workEmail': workEmail,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'maritalStatus': maritalStatus,
      'addressLine1': addressLine1,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'],
      preferredName: map['preferredName'],
      fullName: map['fullName'],
      jobTitle: map['jobTitle'],
      profilePicture: map['profilePicture'],
      workPhone: map['workPhone'],
      mobilePhone: map['mobilePhone'],
      workEmail: map['workEmail'],
      gender: map['gender'],
      dateOfBirth: map['dateOfBirth'],
      maritalStatus: map['maritalStatus'],
      addressLine1: map['addressLine1'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zipCode'],
    );
  }

  static UserInfo jakeBryan = UserInfo(
    id: 1,
    firstName: 'Jake',
    lastName: 'Bryan',
    middleName: 'M.',
    preferredName: 'Jake',
    fullName: 'Jake M. Bryan',
    jobTitle: 'VP, People & Culture',
    profilePicture: 'assets/profile.png',
    workPhone: '555-555-5555',
    mobilePhone: '555-555-5555',
    workEmail: 'jake@example.com',
    gender: 'Male',
    dateOfBirth: '1985-04-12',
    maritalStatus: 'Single',
    addressLine1: '123 E. Main St',
    city: 'Lehi',
    state: 'UT',
    zipCode: '84043',
  );
}

// Data for the Job Tab
class JobInfo {
  final String jobTitle;
  final String department;
  final String reportsTo;
  final String employmentStatus;
  final String hireDate;
  final String compensation;
  final String hourlyRate;
  final String paySchedule;
  final String lastRaise;

  const JobInfo({
    required this.jobTitle,
    required this.department,
    required this.reportsTo,
    required this.employmentStatus,
    required this.hireDate,
    required this.compensation,
    required this.hourlyRate,
    required this.paySchedule,
    required this.lastRaise,
  });

  static const JobInfo jakeBryanJob = JobInfo(
    jobTitle: 'Software Engineer',
    department: 'Engineering',
    reportsTo: 'Samantha Jones',
    employmentStatus: 'Full Time',
    hireDate: 'January 15, 2021',
    compensation: '\$115,000.00 / year',
    hourlyRate: '\$55.29 / hour',
    paySchedule: 'Semi-monthly',
    lastRaise: 'January 2024',
  );
}

// Data for the Time Off Tab
class TimeOffBalance {
  final String type;
  final double availableHours;
  final double requestedHours;

  const TimeOffBalance({
    required this.type,
    required this.availableHours,
    required this.requestedHours,
  });

  static const List<TimeOffBalance> balances = [
    TimeOffBalance(
      type: 'Vacation',
      availableHours: 120.0,
      requestedHours: 8.0,
    ),
    TimeOffBalance(
      type: 'Sick Leave',
      availableHours: 40.0,
      requestedHours: 0.0,
    ),
    TimeOffBalance(
      type: 'Personal Time',
      availableHours: 16.0,
      requestedHours: 0.0,
    ),
  ];
}

// Data for the Emergency Tab
class EmergencyContact {
  final String name;
  final String relationship;
  final String phoneNumber;
  final bool isPrimary;

  const EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.isPrimary = false,
  });

  static const List<EmergencyContact> contacts = [
    EmergencyContact(
      name: 'Sarah Bryan',
      relationship: 'Spouse',
      phoneNumber: '801-555-1234',
      isPrimary: true,
    ),
    EmergencyContact(
      name: 'John Bryan',
      relationship: 'Father',
      phoneNumber: '801-555-5678',
    ),
  ];
}

// Data for the Benefits Tab
class BenefitPlan {
  final String name;
  final String status;
  final String coverage;

  const BenefitPlan({
    required this.name,
    required this.status,
    required this.coverage,
  });

  static const List<BenefitPlan> plans = [
    BenefitPlan(
      name: 'Medical',
      status: 'Enrolled',
      coverage: 'Employee + Family',
    ),
    BenefitPlan(name: 'Dental', status: 'Enrolled', coverage: 'Employee Only'),
    BenefitPlan(
      name: 'Vision',
      status: 'Enrolled',
      coverage: 'Employee + Spouse',
    ),
    BenefitPlan(name: '401k', status: 'Enrolled', coverage: 'Employee'),
  ];
}

// Data for the Documents Tab
class Document {
  final String name;
  final String date;
  final IconData icon;

  const Document({required this.name, required this.date, required this.icon});

  static const List<Document> documents = [
    Document(
      name: 'Employee Handbook',
      date: 'Jan 15, 2021',
      icon: Icons.folder,
    ),
    Document(
      name: '2023 W-2 Tax Form',
      date: 'Jan 25, 2024',
      icon: Icons.description,
    ),
    Document(
      name: 'Performance Review 2023',
      date: 'Dec 15, 2023',
      icon: Icons.star,
    ),
    Document(
      name: 'Offer Letter',
      date: 'Jan 5, 2021',
      icon: Icons.description,
    ),
  ];
}

// Data for the Training Tab
class Training {
  final String name;
  final String status;
  final String date;

  const Training({
    required this.name,
    required this.status,
    required this.date,
  });

  static const List<Training> courses = [
    Training(
      name: 'Information Security',
      status: 'Completed',
      date: 'Mar 1, 2024',
    ),
    Training(
      name: 'Workplace Harassment Prevention',
      status: 'Completed',
      date: 'Mar 1, 2024',
    ),
    Training(
      name: 'Onboarding Checklist',
      status: 'Completed',
      date: 'Jan 15, 2021',
    ),
    Training(
      name: 'New Employee Orientation',
      status: 'Assigned',
      date: 'No Due Date',
    ),
  ];
}
