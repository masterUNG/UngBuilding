import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungbuilding/models/product_model.dart';
import 'package:ungbuilding/screens/add_product.dart';
import 'package:ungbuilding/screens/detail_product.dart';
import 'package:ungbuilding/utility/my_style.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field
  List<ProductModel> productModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    readAllProduct();
  }

  Future<void> readAllProduct() async {
    try {
      if (productModels.length != 0) {
        productModels.removeWhere((ProductModel productModel) {
          return productModel != null;
        });
      }

      Response response = await Dio().get(MyConstant().urlGetAllProduct);
      // print('response ===>>> $response');
      var dataResponse = response.data['data'];
      print('dataResponse = $dataResponse');

      for (var map in dataResponse) {
        ProductModel productModel = ProductModel.fromJson(map);
        setState(() {
          productModels.add(productModel);
        });
      }
    } catch (e) {}
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showContent() {
    return productModels.length == 0 ? showProcess() : showListView();
  }

  Widget showPic(int index) {
    return Container(
      child: Image.network(productModels[index].picture),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
    );
  }

  Widget showProduct(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5 - 20,
          child: Text(
            productModels[index].producrt,
            style: index % 2 == 0
                ? MyStyle().h1TextStyle
                : MyStyle().h1TextStyleWhite,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          productModels[index].detail,
          style: TextStyle(
              color: index % 2 == 0 ? MyStyle().textColor : Colors.white),
        ),
      ],
    );
  }

  Widget showText(int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          showProduct(index),
          showDetail(index),
        ],
      ),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
    );
  }

  ListView showListView() => ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            onTap: () {
              MaterialPageRoute materialPageRoute =
                  MaterialPageRoute(builder: (BuildContext buildContext) {
                return DetailProduct(
                  productModel: productModels[index],
                );
              });
              Navigator.of(context).push(materialPageRoute);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? MyStyle().mainColor
                      : MyStyle().barColor),
              child: Row(
                children: <Widget>[
                  showPic(index),
                  showText(index),
                ],
              ),
            ),
          );
        },
      );

  Widget addProductButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30.0, right: 30.0),
              child: FloatingActionButton(
                backgroundColor: MyStyle().barColor,
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddProduct();
                  });
                  Navigator.of(context).push(materialPageRoute).then((resonse) {
                    readAllProduct();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showContent(),
        addProductButton(),
      ],
    );
  }
}
