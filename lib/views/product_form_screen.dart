import 'package:flutter/material.dart';
import 'package:shop/widgets/app_drawer.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocosNode = FocusNode();
  final _descriptionFocosNode = FocusNode();
  final _imageUrlFocosNode = FocusNode();
  final _imageUrlCoontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageUrlFocosNode.addListener(_updateImage);
  }

  void _updateImage() {
    // update component when exit end get most recent updates
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocosNode.dispose();
    _descriptionFocosNode.dispose();
    _descriptionFocosNode.removeListener(_updateImage);
    _imageUrlFocosNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulário Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocosNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocosNode,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocosNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                // textInputAction: TextInputAction.next,
                focusNode: _descriptionFocosNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocosNode,
                      controller: _imageUrlCoontroller,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlCoontroller.text.isEmpty
                        ? Text("Informe a URL")
                        : FittedBox(
                            child: Image.network(_imageUrlCoontroller.text),
                            fit: BoxFit.cover,
                          ),
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
