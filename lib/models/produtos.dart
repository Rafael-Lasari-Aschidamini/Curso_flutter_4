import 'package:flutter/material.dart';

class Produtos with ChangeNotifier {
  final String id;
  final String titulo;
  final String descricao;
  final double valor;
  final String imageUrl;
  bool isFavorite;

  Produtos({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
