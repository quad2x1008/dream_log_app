import 'package:dream_log_app/widgets/dream_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DreamJournalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dream Journal'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('dreams').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No dreams saved yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          final dreams = snapshot.data!.docs;

          return ListView.builder(
            itemCount: dreams.length,
            itemBuilder: (context, index) {
              final dream = dreams[index];
              return DreamCard(
                dreamId: dream.id,
                title: dream['title'],
                mood: dream['mood'],
                description: dream['description'],
              );
            },
          );
        },
      ),
    );
  }
}

class DreamDetailScreen extends StatelessWidget {
  final String dreamId;
  final String title;
  final String mood;
  final String description;

  DreamDetailScreen({
    required this.dreamId,
    required this.title,
    required this.mood,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dream Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Mood
            Row(
              children: [
                Text(
                  'Mood: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Text(
                    mood, // Emoji or color
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Description
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              description.isNotEmpty ? description : 'No description provided.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
