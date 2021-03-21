import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStatefulApp();
  }
}

class MyStatefulApp extends StatefulWidget {
  @override
  _MyStatefulAppState createState() => _MyStatefulAppState();
}

class _MyStatefulAppState extends State<MyStatefulApp> {
  String orderName, answer = "";
  List<String> names = [];
  List<String> pics = [];
  List<String> urls = [];
  List<String> vendors = [];
  List<String> saleNotes = [];
  List<String> descript = [];
  List<int> prices = [];
  List<List> pictures = [];

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  void getData() async {
    pics.clear();
    names.clear();
    prices.clear();
    pictures.clear();
    descript.clear();
    vendors.clear();
    urls.clear();
    saleNotes.clear();
    setState(() {});
    Response response =
        await get("http://server.getoutfit.ru/offers?description=$orderName");
    var statCode = response.statusCode;
    if (statCode == 200) {
      var decodedAns = jsonDecode(response.body);
      if (decodedAns.lenght == 0) {
        setState(() {
          answer = "Не найдено";
        });
      }
      for (int i = 0; i < decodedAns.length; i++) {
        names.add(utf8convert(decodedAns[i]["name"]));
        pics.add(decodedAns[i]["pictures"][0]);
        prices.add(decodedAns[i]["price"]);
        urls.add(decodedAns[i]["url"]);
        pictures.add(decodedAns[i]["pictures"]);
        descript.add(utf8convert(decodedAns[i]["description"]));
        vendors.add(utf8convert(decodedAns[i]["vendor"]));
        saleNotes.add(utf8convert(decodedAns[i]["sales_notes"]));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15),
                    hintText: 'Введите название товара',
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.search),
                      onTap: () {
                        getData();
                      },
                    ),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.purple)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (text) {
                    setState(() {
                      orderName = text;
                    });
                  },
                ),
              ),
              Divider(thickness: 1.5, color: Colors.blue),
              Text(answer),
              Expanded(
                  child: ListView.separated(
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(
                        names[index],
                        style:
                            TextStyle(fontFamily: "Sans-Serif", fontSize: 13),
                      ),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.5, color: Colors.blue),
                          ),
                        ),
                        child: Image.network(pics[index]),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Order(
                                name: names[index],
                                descript: descript[index],
                                url: urls[index],
                                salesNote: saleNotes[index],
                                vendor: vendors[index],
                                pictures: pictures[index],
                                price: prices[index]),
                          )),
                      subtitle: Text(
                        "Цена: " + prices[index].toString() + " руб.",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        textAlign: TextAlign.right,
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1.5,
                    color: Colors.blue,
                  );
                },
              ))
            ],
          ),
        )));
  }
}
