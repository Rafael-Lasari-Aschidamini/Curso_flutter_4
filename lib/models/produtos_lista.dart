import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exceptions.dart';
import 'package:projeto_loja/models/produtos.dart';

class ProdutosLista with ChangeNotifier {
  final _baseUrl =
      'https://projeto-loja-9b94c-default-rtdb.firebaseio.com/produtos';
  final List<Produtos> _items = [];
  List<Produtos> get items => [..._items];
  List<Produtos> get itemsFavoritos =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> carregarProdutos() async {
    _items.clear();

    final resposta = await http.get(
      Uri.parse('$_baseUrl.json'),
    );
    if (resposta.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(resposta.body);
    data.forEach(
      (produtoId, produtoData) {
        _items.add(
          Produtos(
            id: produtoId,
            titulo: produtoData['name'],
            descricao: produtoData['description'],
            valor: produtoData['price'],
            imageUrl: produtoData['imageUrl'],
            isFavorite: produtoData['isFavorite'],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> salvarProduto(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final produto = Produtos(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      titulo: data['name'] as String,
      descricao: data['description'] as String,
      valor: double.parse(data['price'].toString()),
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduto(produto);
    } else {
      return adicionarProduto(produto);
    }
  }

  Future<void> adicionarProduto(Produtos produtos) async {
    final resposta = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode(
        {
          "name": produtos.titulo,
          "description": produtos.descricao,
          "price": produtos.valor,
          "imageUrl": produtos.imageUrl,
          "isFavorite": produtos.isFavorite,
        },
      ),
    );

    final id = jsonDecode(resposta.body)['name'];
    _items.add(
      Produtos(
        id: id,
        titulo: produtos.titulo,
        descricao: produtos.descricao,
        valor: produtos.valor,
        imageUrl: produtos.imageUrl,
        isFavorite: produtos.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduto(Produtos produtos) async {
    int indexs = _items.indexWhere((p) => p.id == produtos.id);
    if (indexs >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${produtos.id}.json'),
        body: jsonEncode(
          {
            "name": produtos.titulo,
            "description": produtos.descricao,
            "price": produtos.valor,
            "imageUrl": produtos.imageUrl,
            "isFavorite": produtos.isFavorite,
          },
        ),
      );
      _items[indexs] = produtos;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> removerProduto(Produtos produtos) async {
    int indexs = _items.indexWhere((p) => p.id == produtos.id);
    if (indexs >= 0) {
      final produto = _items[indexs];
      _items.remove(produto);
      notifyListeners();

      final resposta = await http.delete(
        Uri.parse('$_baseUrl/${produtos.id}'),
      );
      if (resposta.statusCode >= 400) {
        _items.insert(indexs, produtos);
        notifyListeners();
        throw HttpExceptions(
          msg: 'Não foi possivel excluir',
          statusCode: resposta.statusCode,
        );
      }
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
