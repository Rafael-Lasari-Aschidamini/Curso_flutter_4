import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:projeto_loja/components/product_grid_item.dart';
import 'package:provider/provider.dart';

import '../models/produtos.dart';
import '../models/produtos_lista.dart';

class GridProduto extends StatelessWidget {
  const GridProduto(this.mostrarFavoritos, {super.key});

  final bool mostrarFavoritos;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutosLista>(context);

    final List<Produtos> carregarProdutos =
        mostrarFavoritos ? provider.itemsFavoritos : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: carregarProdutos.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        child: ProductGridItem(),
        value: carregarProdutos[i],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
