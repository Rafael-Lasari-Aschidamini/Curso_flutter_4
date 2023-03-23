import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_loja/models/pedidos.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.pedidos});
  final Pedidos pedidos;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expandir = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.pedidos.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy  hh:mm').format(widget.pedidos.data),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(
                  () {
                    _expandir = !_expandir;
                  },
                );
              },
            ),
          ),
          if (_expandir)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: (widget.pedidos.produtos.length * 25.0) + 10,
              child: ListView(
                children: widget.pedidos.produtos.map((produto) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        produto.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${produto.quantidade}x R\$ ${produto.valor}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
