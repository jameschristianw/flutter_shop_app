import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/productProvider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController _imageUrlController = TextEditingController();
  // TextEditingController _titleUrlController = TextEditingController();
  // TextEditingController _priceUrlController = TextEditingController();
  // TextEditingController _descriptionUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _imageUrlFocusNode = FocusNode();
  Product _edittedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _edittedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _edittedProduct.title,
          'price': _edittedProduct.price.toString(),
          'description': _edittedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _edittedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('.jpg'))) return;

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) return;

    _formKey.currentState.save();
    if (_edittedProduct.id != null)
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_edittedProduct.id, _edittedProduct);
    else
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_edittedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                // controller: _titleUrlController,
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a value';
                  return null;
                },
                onSaved: (value) {
                  _edittedProduct = Product(
                    title: value,
                    price: _edittedProduct.price,
                    description: _edittedProduct.description,
                    imageUrl: _edittedProduct.imageUrl,
                    id: _edittedProduct.id,
                    isFavourite: _edittedProduct.isFavourite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                // controller: _priceUrlController,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a price';
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0)
                    return 'Price must be greater than 0';
                  return null;
                },
                onSaved: (value) {
                  _edittedProduct = Product(
                    title: _edittedProduct.title,
                    price: double.parse(value),
                    description: _edittedProduct.description,
                    imageUrl: _edittedProduct.imageUrl,
                    id: _edittedProduct.id,
                    isFavourite: _edittedProduct.isFavourite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // controller: _descriptionUrlController,
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a description';
                  if (value.length < 10)
                    return 'Description should be at least 10 characters long';
                  return null;
                },
                onSaved: (value) {
                  _edittedProduct = Product(
                    title: _edittedProduct.title,
                    price: _edittedProduct.price,
                    description: value,
                    imageUrl: _edittedProduct.imageUrl,
                    id: _edittedProduct.id,
                    isFavourite: _edittedProduct.isFavourite,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(child: Text('Enter a URL'))
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.contain,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide a URL';
                        if (!value.startsWith('http') &&
                            !value.startsWith('https'))
                          return 'Please enter a valid URL';
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.jpg'))
                          return 'Please enter a valid image URL';
                        return null;
                      },
                      onFieldSubmitted: (_) => _saveForm(),
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (value) {
                        _edittedProduct = Product(
                          title: _edittedProduct.title,
                          price: _edittedProduct.price,
                          description: _edittedProduct.description,
                          imageUrl: value,
                          id: _edittedProduct.id,
                          isFavourite: _edittedProduct.isFavourite,
                        );
                      },
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

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }
}
