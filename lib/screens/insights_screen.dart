import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodTracker extends StatefulWidget {
  @override
  _MoodTrackerState createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  Map<String, int> moodCounts = {};
  String chartType = 'Pie'; // Default chart type

  // Update mood counts from Firestore
  void _updateMoodCounts(QuerySnapshot snapshot) {
    final newMoodCounts = <String, int>{};

    // Count the moods based on emoji and color
    for (var dream in snapshot.docs) {
      final mood = dream['mood'];
      newMoodCounts[mood] = (newMoodCounts[mood] ?? 0) + 1;
    }

    setState(() {
      moodCounts = newMoodCounts;
    });
  }

  // Initialize mood data listener
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection('dreams').snapshots().listen((snapshot) {
      _updateMoodCounts(snapshot);
    });
  }

  // Get pie chart data sections
  List<PieChartSectionData> _getPieChartSections() {
    return moodCounts.entries.map((entry) {
      return PieChartSectionData(
        color: _getMoodColor(entry.key),
        value: entry.value.toDouble(),
        title: '${entry.key}: ${entry.value}',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  // Get color based on mood (emoji or color)
  Color _getMoodColor(String mood) {
    switch (mood) {
      case "😀": return Colors.yellow;
      case "😴": return Colors.blue;
      case "😱": return Colors.red;
      case "🤔": return Colors.green;
      case "🌈": return Colors.purple;
      case "🔥": return Colors.orange;
      default: return Colors.grey;
    }
  }

  // Switch chart type (Only Pie)
  void _onChartTypeChanged(String? value) {
    setState(() {
      chartType = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Remove dropdown for switching chart type
            SizedBox(height: 20),
            if (moodCounts.isEmpty)
              Center(child: Text('No data available. Log some dreams!'))
            else
              Expanded(
                child: _buildChart(),
              ),
          ],
        ),
      ),
    );
  }

  // Build the Pie chart
  Widget _buildChart() {
    return PieChart(
      PieChartData(
        sections: _getPieChartSections(),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
      ),
    );
  }
}
