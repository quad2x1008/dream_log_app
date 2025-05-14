import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dream_model.dart';

class DreamProvider with ChangeNotifier {
  final List<Dream> _dreams = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Dream> get dreams => _dreams;

  Future<void> addDream(Dream dream) async {
    await _firestore.collection('dreams').doc(dream.id).set(dream.toMap());
    _dreams.add(dream);
    notifyListeners();
  }

  Future<void> fetchDreams() async {
    final querySnapshot = await _firestore.collection('dreams').get();
    _dreams.clear();
    for (var doc in querySnapshot.docs) {
      _dreams.add(Dream.fromMap(doc.data()));
    }
    notifyListeners();
  }
}
