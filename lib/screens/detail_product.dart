import 'package:flutter/material.dart';
import 'package:ungbuilding/models/product_model.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct({Key key, this.productModel}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  // Field
  String nameProduct = '';
  ProductModel myProductModel;

  // Method
  @override
  void initState() { 
    super.initState();
    myProductModel = widget.productModel;
    if (myProductModel != null) {
      nameProduct = myProductModel.producrt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$nameProduct'),
      ),
    );
  }
}
