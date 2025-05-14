import 'package:dream_log_app/screens/dream_journal_screen.dart';
import 'package:dream_log_app/screens/insights_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DreamLogScreen extends StatefulWidget {
  @override
  _DreamLogScreenState createState() => _DreamLogScreenState();
}

class _DreamLogScreenState extends State<DreamLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedMood;
  bool _useEmojiMood = true; // Default to emoji-based mood selector

  final List<String> _emojiMoods = ["😀", "😴", "😱", "🤔", "🌈", "🔥"];
  final List<Color> _colorMoods = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];

  Future<void> _saveDream() async {
    if (_formKey.currentState!.validate()) {
      final dreamData = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "mood": _selectedMood ?? "No Mood",
        "timestamp": DateTime.now(),
      };

      try {
        await FirebaseFirestore.instance.collection('dreams').add(dreamData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dream entry saved successfully!')),
        );

        // Reset all fields and selections after saving the dream
        _formKey.currentState!.reset();
        setState(() {
          _titleController.clear();
          _descriptionController.clear();
          _selectedMood = null;
          _useEmojiMood = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving dream: $e')),
        );
      }
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _logout(); // Log the user out if confirmed
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dream Log'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showLogoutDialog, // Show logout confirmation dialog
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Dream Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    } else if (value.length < 3) {
                      return 'Title must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Dream Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                SwitchListTile(
                  title: Text('Use Emoji Mood Selector'),
                  value: _useEmojiMood,
                  onChanged: (value) => setState(() => _useEmojiMood = value),
                ),
                SizedBox(height: 8),
                Text('Select Mood', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                if (_useEmojiMood)
                  Wrap(
                    spacing: 10,
                    children: _emojiMoods.map((emoji) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMood = emoji),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor:
                          _selectedMood == emoji ? Colors.deepPurple : Colors.grey[200],
                          child: Text(
                            emoji,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                if (!_useEmojiMood)
                  Wrap(
                    spacing: 10,
                    children: _colorMoods.map((color) {
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMood = color.value.toString()),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: color,
                          child: _selectedMood == color.value.toString()
                              ? Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveDream,
                        child: Text('Save Dream'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DreamJournalScreen()), // Navigate to Mood Tracker
                          );
                        },
                        child: Text('View Log Details'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.deepPurple),
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MoodTracker()), // Navigate to Mood Tracker
                          );
                        },
                        child: Text('View Mood Tracker'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.deepPurple),
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
