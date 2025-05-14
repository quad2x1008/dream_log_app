import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final String selectedMood;
  final ValueChanged<String> onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final moods = ['😊', '😢', '😠', '😴', '😍'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: moods.map((mood) {
        final isSelected = mood == selectedMood;
        return GestureDetector(
          onTap: () => onMoodSelected(mood),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Text(
              mood,
              style: TextStyle(
                fontSize: 20,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
