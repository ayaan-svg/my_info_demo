import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import 'database_helper.dart'; // Import the new DatabaseHelper
import 'data.dart'; // Import the UserInfo data model
import 'personal_tab.dart';
import 'job_tab.dart';
import 'time_off_tab.dart';
import 'performance.dart';
import 'emergency_tab.dart';
import 'benefits.dart';
import 'documents_tab.dart';
import 'training_tab.dart';
import 'placeholders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Explicitly initialize the database factory based on the platform.
  // This is the key to solving the 'databaseFactory not initialized' error.
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize the database and insert the initial data
  final dbHelper = DatabaseHelper();
  await dbHelper.insertInitialData(UserInfo.jakeBryan);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BambooHR Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF07E2E), // BambooHR orange
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const PlaceholderScreen(title: 'Home'),
      const PlaceholderScreen(title: 'Inbox'),
      const MyInfoScaffold(),
      const PlaceholderScreen(title: 'People'),
      const PlaceholderScreen(title: 'More'),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Info'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'People'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF07E2E),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class MyInfoScaffold extends StatelessWidget {
  const MyInfoScaffold({super.key});

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
            tabAlignment: TabAlignment.start,
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
