import 'package:flutter/material.dart';
import 'journal_database.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    try {
      final data = await JournalDatabase.instance.getEntries();
      setState(() => _entries = data);
    } catch (e) {
      debugPrint("⚠️ Error loading entries: $e");
    }
  }

  Future<void> _saveEntry() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nothing to save — write something first ✍️"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await JournalDatabase.instance.insertEntry(text);
      _controller.clear();
      await _loadEntries();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Journal entry saved 💚"),
          duration: Duration(seconds: 2),
        ),
      );

      debugPrint("✅ Entry saved successfully.");
    } catch (e) {
      debugPrint("❌ Error saving entry: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save entry: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    JournalDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFAEDFF7),
        title: const Text(
          "Your Journal ✨",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                "Write down your thoughts or feelings below. Reflect and release 🌿",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),

              // Text input
              Flexible(
                flex: 2,
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Start writing your journal here...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Save button
              ElevatedButton.icon(
                onPressed: _saveEntry,
                icon: const Icon(Icons.save),
                label: const Text("Save Entry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2DFDB),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                ),
              ),

              const SizedBox(height: 20),

              // List of saved entries
              Flexible(
                flex: 3,
                child: _entries.isEmpty
                    ? const Center(
                        child: Text(
                          "No entries yet 🌱",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _entries.length,
                        itemBuilder: (context, index) {
                          final entry = _entries[index];
                          final date = DateTime.tryParse(entry['date'] ?? "");
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1F2EB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry['content'] ?? "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  date != null
                                      ? "🗓️ ${date.toLocal().toString().substring(0, 16)}"
                                      : "🗓️ Unknown date",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
