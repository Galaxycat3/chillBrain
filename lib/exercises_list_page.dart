import 'package:flutter/material.dart';
import 'exercise_detail_page.dart';

class ExercisesListPage extends StatelessWidget {
  const ExercisesListPage({super.key});

  static final List<_Exercise> _items = [
    _Exercise(
      title: 'Box Breathing',
      subtitle: '4-4-4-4 pattern',
      minutes: 3,
      color: const Color(0xFFFFF9C4),
      steps: const [
        'Inhale 4s',
        'Hold 4s',
        'Exhale 4s',
        'Hold 4s',
        'Repeat 4 rounds',
      ],
      description: 'Steady rhythm to calm the nervous system.',
      category: 'Breath',
    ),
    _Exercise(
      title: 'Body Scan',
      subtitle: 'Head to toe',
      minutes: 5,
      color: const Color(0xFFE1F5FE),
      steps: const ['Close eyes', 'Scan head to toes', 'Release tension'],
      description: 'Gentle awareness of each body area.',
      category: 'Body',
    ),
    _Exercise(
      title: 'Mindful Listening',
      subtitle: 'Ambient focus',
      minutes: 4,
      color: const Color(0xFFE8F5E9),
      steps: const ['Sit still', 'Notice 3 sounds', 'Return to breath'],
      description: 'Let sounds come and go without judgment.',
      category: 'Focus',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9C4),
        title: const Text(
          'Guided Exercises',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final twoCols = c.maxWidth >= 700;
          final query = ValueNotifier<String>('');
          final cat = ValueNotifier<String>('All');
          final cats = const ['All', 'Breath', 'Body', 'Focus'];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (v) => query.value = v.trim().toLowerCase(),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<String>(
                  valueListenable: cat,
                  builder: (_, selected, __) {
                    return Wrap(
                      spacing: 8,
                      children: [
                        for (final cName in cats)
                          ChoiceChip(
                            label: Text(cName),
                            selected: selected == cName,
                            onSelected: (_) => cat.value = cName,
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: query,
                    builder: (_, q, __) {
                      return ValueListenableBuilder<String>(
                        valueListenable: cat,
                        builder: (_, selected, __) {
                          final items = _items.where((e) {
                            final matchQ =
                                q.isEmpty ||
                                e.title.toLowerCase().contains(q) ||
                                e.subtitle.toLowerCase().contains(q) ||
                                e.description.toLowerCase().contains(q);
                            final matchC =
                                selected == 'All' || e.category == selected;
                            return matchQ && matchC;
                          }).toList();
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: twoCols ? 2 : 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: twoCols ? 2.8 : 2.5,
                                ),
                            itemCount: items.length,
                            itemBuilder: (context, i) =>
                                _ExerciseCard(ex: items[i]),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final _Exercise ex;
  const _ExerciseCard({required this.ex});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ex.color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 250), // fade
              pageBuilder: (_, __, ___) => ExerciseDetailPage(
                title: ex.title,
                description: ex.description,
                steps: ex.steps,
                minutes: ex.minutes,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Hero(
                tag: ex.title, // hero
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.self_improvement,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ex.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ex.subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(Icons.timer, size: 18, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    '${ex.minutes} min',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Exercise {
  final String title;
  final String subtitle;
  final int minutes;
  final Color color;
  final List<String> steps;
  final String description;
  final String category;
  const _Exercise({
    required this.title,
    required this.subtitle,
    required this.minutes,
    required this.color,
    required this.steps,
    required this.description,
    required this.category,
  });
}
