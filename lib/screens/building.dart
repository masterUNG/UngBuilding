import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungbuilding/utility/my_style.dart';

class Building extends StatefulWidget {
  @override
  _BuildingState createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  // Field
  String nameLogin = '...';

  // Method
  @override
  void initState() {
    super.initState();
    findDataLogin();
  }

  Future<String> findUrlAPI() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user = sharedPreferences.getString('User');
    String url = '${MyConstant().urlHost}api/users/getuser/$user';
    return url;
  }

  Future<void> findDataLogin() async {
    String url = await findUrlAPI();
    print('url = $url');

    Response response = await Dio().get(url);
    // print('response = $response');
    var result = response.data['data'];
    print('result = $result');

    for (var map in result) {
      setState(() {
        nameLogin = map['name'];
      });
      print('nameLogin = $nameLogin');
    }
  }

  Widget menuListProduct() {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text('List Product'),
      subtitle: Text('Descrip List Product'),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuInformation() {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text('Information'),
      subtitle: Text('Descrip Information'),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: Colors.red,
      ),
      title: Text(
        'Sign Out',
        style: TextStyle(color: Colors.red),
      ),
      subtitle: Text(
        'Sign Out and Back to Authen Page',
        style: TextStyle(color: Colors.red.shade300),
      ),onTap: (){
        Navigator.of(context).pop();

      },
    );
  }

  

  Widget showNameLogin() {
    return Text('Login by $nameLogin');
  }

  Widget showAppName() {
    return Text(
      'Ung Building',
      style: MyStyle().h1TextStyle,
    );
  }

  Widget showLogo() {
    return Container(
      height: 80.0,
      width: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showNameLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuListProduct(),
          menuInformation(),
          menuSignOut(),
        ],
      ),
    );
  }

  Widget searchForm() {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Search Build',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: searchForm(),
      ),
    );
  }
}
