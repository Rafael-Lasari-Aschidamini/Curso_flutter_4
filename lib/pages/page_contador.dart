import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:projeto_loja/models/produtos.dart';
import 'package:projeto_loja/providers/conter.dart';

class PageContador extends StatefulWidget {
  const PageContador({
    super.key,
  });

  @override
  State<PageContador> createState() => _PageContadorState();
}

class _PageContadorState extends State<PageContador> {
  @override
  Widget build(BuildContext context) {
    final Produtos produto =
        ModalRoute.of(context)!.settings.arguments as Produtos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplon contador'),
      ),
      body: Column(
        children: [
          Text(ConterProvider.of(context)?.state.value.toString() ?? '0'),
          IconButton(
            onPressed: () {
              setState(() {});
              ConterProvider.of(context)?.state.inc();
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {});
              ConterProvider.of(context)?.state.dec();
            },
            icon: const Icon(Icons.remove_outlined),
          )
        ],
      ),
    );
  }
}
