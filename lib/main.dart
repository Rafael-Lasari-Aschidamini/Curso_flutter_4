import 'package:flutter/material.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:projeto_loja/pages/page_contador.dart';
import 'package:projeto_loja/pages/page_detalhes_produtos.dart';
import 'package:projeto_loja/pages/page_products_overview.dart';
import 'package:projeto_loja/providers/conter.dart';
import 'package:projeto_loja/utils/rotas_aplicacao.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ConterProvider(
      child: ChangeNotifierProvider(
        create: (_) => ProdutosLista(),
        child: MaterialApp(
          title: 'Projeto Loja',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange),
              fontFamily: 'Lato'),
          home: PageProductsOverview(),
          routes: {
            RotasAplicacao.DETALHE_PRODUTO: (ctx) =>
                const PageDetalhesProdutos()
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
