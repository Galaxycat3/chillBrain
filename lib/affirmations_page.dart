import 'package:flutter/material.dart';
import 'dart:math';

class AffirmationsPage extends StatefulWidget {
  const AffirmationsPage({super.key});

  @override
  State<AffirmationsPage> createState() => _AffirmationsPageState();
}

class _AffirmationsPageState extends State<AffirmationsPage> {
  final List<String> _affirmations = [
    "You are enough just as you are 🌸",
    "Every day is a fresh start 🌿",
    "You are stronger than you think 💪",
    "Peace begins with a smile 😊",
    "Believe in yourself and all that you are ✨",
    "You deserve love and happiness 💖",
    "Small steps every day lead to big changes 🌱",
    "Your mind is a powerful tool 🧠",
  ];

  final Random _random = Random();
  int _currentIndex = 0;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = _random.nextInt(_affirmations.length);
  }

  void _nextAffirmation() {
    setState(() {
      int newIndex;
      do {
        newIndex = _random.nextInt(_affirmations.length);
      } while (newIndex == _currentIndex);
      _currentIndex = newIndex;
      _isLiked = false; // reset heart on new affirmation
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC1CC),
        title: const Text(
          "Positive Affirmations 🌸",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // swipe up
            _nextAffirmation();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      _affirmations[_currentIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.redAccent : Colors.black54,
                    size: 36,
                  ),
                  onPressed: _toggleLike,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Swipe up to see another affirmation",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
