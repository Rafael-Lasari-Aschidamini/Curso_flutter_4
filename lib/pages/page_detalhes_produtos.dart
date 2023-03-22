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
      appBar: AppBar(
        title: Text(produto.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                produto.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'R\$ ${produto.valor}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                produto.descricao,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
