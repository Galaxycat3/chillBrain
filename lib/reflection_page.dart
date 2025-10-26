import 'package:flutter/material.dart';

class ReflectionPage extends StatelessWidget {
  const ReflectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final txtStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black87,
      height: 1.4,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBBDEFB),
        title: const Text(
          'Reflection',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Animations elevate clarity and comfort when used with intention. Fades and shared element transitions reduce cognitive load by keeping context visible during screen changes. Animated text switches guide attention without abrupt jumps, which supports calm focus in a wellbeing app.',
                style: txtStyle,
              ),
              const SizedBox(height: 12),
              Text(
                'Motion pairs with meaning. The hero transition from exercise cards to detail connects list items to their destination, reinforcing spatial continuity. Subtle durations feel responsive but not rushed, helping users stay oriented.',
                style: txtStyle,
              ),
              const SizedBox(height: 12),
              Text(
                'Accessibility matters. When the system indicates reduced motion preferences, animations become instant. Text colors use high contrast on light surfaces. These adaptations keep the experience inclusive.',
                style: txtStyle,
              ),
              const SizedBox(height: 12),
              Text(
                'Features enhance usefulness. Local storage keeps journal entries and mood logs available offline. Filters and favorites in exercises help people quickly find what they need. Copy to clipboard enables sharing progress with peers or providers.',
                style: txtStyle,
              ),
              const SizedBox(height: 12),
              Text(
                'Animation flow',
                style: txtStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '• Nav fade between screens 250ms ease in out. Disabled when reduced motion is on.',
                style: txtStyle,
              ),
              const SizedBox(height: 4),
              Text(
                '• Exercise hero from card icon to detail header 250ms. Keeps spatial context.',
                style: txtStyle,
              ),
              const SizedBox(height: 4),
              Text(
                '• Affirmation text switch 300ms fade. Guides focus to the new message.',
                style: txtStyle,
              ),
              const SizedBox(height: 4),
              Text(
                '• Mood face and label 200ms switch. Chart bars animate 300ms. Both stop with reduced motion.',
                style: txtStyle,
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'I understand that you will be graded individually on group assignments and may not receive the same grade as all members.',
                style: txtStyle,
              ),
              const SizedBox(height: 24),
              Text('Signature (_______)', style: txtStyle),
            ],
          ),
        ),
      ),
    );
  }
}
