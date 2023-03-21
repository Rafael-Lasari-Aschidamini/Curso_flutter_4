import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_loja/models/cart_item.dart';
import 'package:projeto_loja/models/produtos.dart';
import 'cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCont {
    return _items.length;
  }

  // void adicionarItem(Produtos produtos) {
  //   if (_items.containsKey(produtos.id)) {
  //     _items.update(
  //       produtos.id,
  //       (existente) => CartItem(
  //         id: existente.id,
  //         produtoId: existente.produtoId,
  //         nome: existente.nome,
  //         quantidade: existente.quantidade,
  //         valor: existente.valor,
  //       ),
  //     );
  //   }else{
  //     _items.putIfAbsent(produtos.id, () => CartItem(
  //       id: Random().nextDouble().toString(),
  //       produtoId: produtos.produtoId,
  //       nome: produtos.,
  //       quantidade: 1,
  //       valor: produtos.valor,),);
  //  }
  // }

  void removerItem(String produtoId) {
    _items.remove(produtoId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
