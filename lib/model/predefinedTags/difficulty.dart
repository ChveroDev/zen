import 'package:flutter/material.dart';

enum Difficulty {
  easy(difficulty: 1, color: Colors.green),
  medium(difficulty: 2, color: Colors.yellow),
  difficult(difficulty: 3, color: Colors.red);

  final int difficulty;
  final Color color;

  const Difficulty({required this.difficulty, required this.color});

  static Difficulty findByDifficulty(int difficulty) {
    return Difficulty.values
        .where((item) => item.difficulty == difficulty)
        .first;
  }
}
