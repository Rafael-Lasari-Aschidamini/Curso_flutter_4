import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projeto_loja/models/cart.dart';
import 'package:projeto_loja/models/pedidos.dart';

class ListaPedidos with ChangeNotifier {
  List<Pedidos> _itensPedidos = [];
  List<Pedidos> get itensPedidos {
    return [..._itensPedidos];
  }

  int get contagemItens {
    return _itensPedidos.length;
  }

  void adicionarPedido(Cart cart) {
    _itensPedidos.insert(
      0,
      Pedidos(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          data: DateTime.now(),
          produtos: cart.items.values.toList()),
    );
    notifyListeners();
  }
}
