import 'package:flutter/material.dart';
import 'mood_database.dart';

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({super.key});

  @override
  State<MoodTrackerPage> createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  double _mood = 3;
  final List<String> _labels = ['Very low', 'Low', 'Okay', 'Good', 'Great'];
  final List<String> _faces = ['😔', '🙁', '😐', '🙂', '😄'];

  List<Map<String, dynamic>> _recentMoods = [];

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    final data = await MoodDatabase.instance.getMoods();
    setState(() => _recentMoods = data);
  }

  Future<void> _saveMood() async {
    final level = _mood.round();
    await MoodDatabase.instance.insertMood(level);
    await _loadMoods();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood saved for today 💚')),
    );
  }

  @override
  void dispose() {
    MoodDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int idx = _mood.round() - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1BEE7),
        title: const Text(
          'Mood Tracker',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'How are you feeling today',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                Text(
                  _faces[idx],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 56),
                ),
                const SizedBox(height: 8),
                Text(
                  _labels[idx],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Slider(
                  value: _mood,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _labels[idx],
                  activeColor: Colors.teal,
                  onChanged: (v) => setState(() => _mood = v),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _saveMood,
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0F2F1),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Recent Moods',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _recentMoods.length,
                    itemBuilder: (context, index) {
                      final entry = _recentMoods[index];
                      final date = DateTime.tryParse(entry['date'] ?? '');
                      final level = entry['level'] as int;
                      return _MoodChip(
                        face: _faces[level - 1],
                        label: "${_labels[level - 1]} (${date != null ? date.toLocal().toString().substring(0, 16) : ''})",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  final String face;
  final String label;
  const _MoodChip({required this.face, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color(0xFFD1F2EB),
      label: Text('$face  $label'),
      labelStyle: const TextStyle(color: Colors.black87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
