import 'package:flutter/material.dart';
import 'package:projeto_loja/data/dummy_data.dart';
import 'package:projeto_loja/models/produtos.dart';

class ProdutosLista with ChangeNotifier {
  List<Produtos> _items = dummyProdutos;
  List<Produtos> get items => [..._items];
  List<Produtos> get itemsFavoritos =>
      _items.where((prod) => prod.isFavorite).toList();

  void adicionarProduto(Produtos produtos) {
    _items.add(produtos);
    notifyListeners();
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
