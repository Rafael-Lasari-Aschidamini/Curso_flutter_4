import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:projeto_loja/components/order.dart';
import 'package:projeto_loja/models/lista_pedidos.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';

class PagePedidos extends StatelessWidget {
  const PagePedidos({super.key});

  @override
  Widget build(BuildContext context) {
    final ListaPedidos pedidos = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: pedidos.contagemItens,
        itemBuilder: (ctx, i) => OrderWidget(pedidos: pedidos.itensPedidos[i]),
      ),
    );
  }
}
