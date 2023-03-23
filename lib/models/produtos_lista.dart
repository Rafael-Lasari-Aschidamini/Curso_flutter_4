import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto_loja/data/dummy_data.dart';
import 'package:projeto_loja/models/produtos.dart';

class ProdutosLista with ChangeNotifier {
  final List<Produtos> _items = dummyProdutos;
  List<Produtos> get items => [..._items];
  List<Produtos> get itemsFavoritos =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void salvarProduto(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final produto = Produtos(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      titulo: data['name'] as String,
      descricao: data['description'] as String,
      valor: double.parse(data['price'].toString()),
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduto(produto);
    } else {
      adicionarProduto(produto);
    }
  }

  void adicionarProduto(Produtos produtos) {
    _items.add(produtos);
    notifyListeners();
  }

  void updateProduto(Produtos produtos) {
    int indexs = _items.indexWhere((p) => p.id == produtos.id);
    if (indexs >= 0) {
      _items[indexs] = produtos;
      notifyListeners();
    }
  }

  void removerProduto(Produtos produtos) {
    int indexs = _items.indexWhere((p) => p.id == produtos.id);
    if (indexs >= 0) {
      _items.removeWhere((p) => p.id == produtos.id);
      notifyListeners();
    }
  }
}


// bool _mostrarFavoritos = false;

//   void mostrarFavoritos() {
//     _mostrarFavoritos = true;
//     notifyListeners();
//   }

//   void mostrarTodos() {
//     _mostrarFavoritos = false;
//     notifyListeners();
//   }
