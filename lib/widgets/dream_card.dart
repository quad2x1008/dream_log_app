import 'package:flutter/material.dart';

class DreamCard extends StatefulWidget {
  final String dreamId;
  final String title;
  final String mood;
  final String description;

  DreamCard({
    required this.dreamId,
    required this.title,
    required this.mood,
    required this.description,
  });

  @override
  _DreamCardState createState() => _DreamCardState();
}

class _DreamCardState extends State<DreamCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: GestureDetector(
        onTap: () => setState(() {
          _isExpanded = !_isExpanded;
        }),
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collapsed content (always visible)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Text(
                        widget.mood,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                  ],
                ),
                // Expanded content (shown when expanded)
                if (_isExpanded) ...[
                  SizedBox(height: 16),
                  Text(
                    "Mood: ${widget.mood}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description.isNotEmpty
                        ? widget.description
                        : "No description provided.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
