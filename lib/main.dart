import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // <-- Add this
import 'journal_page.dart'; // Import the JournalPage file
import 'affirmations_page.dart';
import 'mood_tracker_page.dart';
import 'exercises_list_page.dart';

void main() {
  // Initialize FFI for desktop (Windows/macOS/Linux)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Chill Brain'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome back 🌸",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Take a deep breath. Let's focus on your wellbeing today.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),

            _buildFeatureButton(
              icon: Icons.favorite_outline,
              label: "Daily Affirmation",
              color: const Color(0xFFFFC1CC),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AffirmationsPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            _buildFeatureButton(
              icon: Icons.self_improvement,
              label: "Journal",
              color: const Color(0xFFAEDFF7),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JournalPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildFeatureButton(
              icon: Icons.format_quote,
              label: "Mood Tracker",
              color: const Color(0xFFE1BEE7),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MoodTrackerPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildFeatureButton(
              icon: Icons.book_outlined,
              label: "Guided Exercises",
              color: const Color(0xFFFFF9C4),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExercisesListPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black87),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
