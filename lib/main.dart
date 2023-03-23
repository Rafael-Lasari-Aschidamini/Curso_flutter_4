import 'package:flutter/material.dart';
import 'package:projeto_loja/models/cart.dart';
import 'package:projeto_loja/models/lista_pedidos.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:projeto_loja/pages/page_cart.dart';
import 'package:projeto_loja/pages/page_detalhes_produtos.dart';
import 'package:projeto_loja/pages/page_formulario_produtos.dart';
import 'package:projeto_loja/pages/page_pedidos.dart';
import 'package:projeto_loja/pages/page_products_overview.dart';
import 'package:projeto_loja/pages/page_produtos.dart';
import 'package:projeto_loja/utils/rotas_aplicacao.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutosLista(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => ListaPedidos(),
        ),
      ],
      child: MaterialApp(
        title: 'Projeto Loja',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange)
              .copyWith(background: Colors.purple),
        ),
        // home: const PageProductsOverview(),
        routes: {
          RotasAplicacao.HOME: (ctx) => PageProductsOverview(),
          RotasAplicacao.DETALHE_PRODUTO: (ctx) => PageDetalhesProdutos(),
          RotasAplicacao.DETALHE_CARRINHO: (ctx) => PageCart(),
          RotasAplicacao.PEDIDOS: (ctx) => PagePedidos(),
          RotasAplicacao.PRODUTO: (ctx) => PageProduto(),
          RotasAplicacao.FORMULARIO_PRODUTO: (ctx) => PageFormularioProdutos(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
