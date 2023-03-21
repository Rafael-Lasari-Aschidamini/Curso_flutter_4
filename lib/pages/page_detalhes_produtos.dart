import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:projeto_loja/models/produtos.dart';

class PageDetalhesProdutos extends StatelessWidget {
  const PageDetalhesProdutos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Produtos produto =
        ModalRoute.of(context)!.settings.arguments as Produtos;
    return Scaffold(
      appBar: AppBar(title: Text(produto.titulo)),
    );
  }
}
