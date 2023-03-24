import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:projeto_loja/models/produtos.dart';
import 'package:projeto_loja/models/produtos_lista.dart';
import 'package:provider/provider.dart';

class PageFormularioProdutos extends StatefulWidget {
  const PageFormularioProdutos({super.key});

  @override
  State<PageFormularioProdutos> createState() => _PageFormularioProdutosState();
}

class _PageFormularioProdutosState extends State<PageFormularioProdutos> {
  final _priceFocus = FocusNode();
  final _descripitionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    _imageUrlController.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argumento = ModalRoute.of(context)?.settings.arguments;
      if (argumento != null) {
        final produto = argumento as Produtos;
        _formData['id'] = produto.id;
        _formData['name'] = produto.titulo;
        _formData['price'] = produto.valor;
        _formData['description'] = produto.descricao;
        _formData['imageUrl'] = produto.imageUrl;
        _imageUrlController.text = produto.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descripitionFocus.dispose();
    _imageUrlController.removeListener(updateImage);
    _imageUrlController.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;

    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      await Provider.of<ProdutosLista>(
        context,
        listen: false,
      ).salvarProduto(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu Erro'),
          content: Text('Ocorreu um erro ao salvar o produto.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
          ],
        ),
      );
    } finally {
      setState(
        () => _isLoading = false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Nome Obrigatório';
                        }
                        if (name.trim().length < 3) {
                          return 'Nome Minimo 3 letras';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descripitionFocus);
                      },
                      onSaved: (price) => _formData['price'] = price ?? '0',
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;
                        if (price <= 0) {
                          return 'Valor Invalido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: InputDecoration(labelText: 'Descrição'),
                      focusNode: _descripitionFocus,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return 'Descrição Obrigatória';
                        }
                        if (description.trim().length < 10) {
                          return 'Descrição Minimo 10 letras';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Url Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Url Invalida';
                              }
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: (_imageUrlController.text.isNotEmpty)
                              ? Container(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                      width: 100,
                                      height: 100,
                                      _imageUrlController.text,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Text('error');
                                      },
                                    ),
                                  ),
                                )
                              : Text('Informe a Url'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
