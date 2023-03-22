import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_loja/models/cart_item.dart';
import 'package:projeto_loja/models/produtos.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.valor * cartItem.quantidade;
    });
    return total;
  }

  void adicionarItem(Produtos produtos) {
    if (_items.containsKey(produtos.id)) {
      _items.update(
        produtos.id,
        (existenteItem) => CartItem(
          id: existenteItem.id,
          produtoId: existenteItem.produtoId,
          nome: existenteItem.nome,
          quantidade: existenteItem.quantidade + 1,
          valor: existenteItem.valor,
        ),
      );
    } else {
      _items.putIfAbsent(
        produtos.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          produtoId: produtos.id,
          nome: produtos.titulo,
          quantidade: 1,
          valor: produtos.valor,
        ),
      );
    }

    notifyListeners();
  }

  void removerItem(String produtoId) {
    _items.remove(produtoId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
