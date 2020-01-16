import 'package:flutter/material.dart';
import 'package:ungbuilding/screens/add_product.dart';
import 'package:ungbuilding/utility/my_style.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field

  // Method
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
                backgroundColor: MyStyle().mainColor,
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return AddProduct();});
                  Navigator.of(context).push(materialPageRoute);
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
        addProductButton(),
      ],
    );
  }
}
