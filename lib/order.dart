import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Order extends StatelessWidget {
  final String name, descript, url, salesNote, vendor;
  final List pictures;
  final int price;

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  const Order({
    Key key,
    @required this.name,
    @required this.descript,
    @required this.url,
    @required this.salesNote,
    @required this.vendor,
    @required this.pictures,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
                Center(
                    child: Container(
                        height: 420,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pictures.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 1.5, color: Colors.blue),
                                      left: BorderSide(
                                          width: 1.5, color: Colors.blue),
                                    ),
                                  ),
                                  child: Image.network(pictures[index]));
                            }))),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(name,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                Text("Описание товара:",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(descript,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                Text("Производитель: " + vendor,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                Text("Цена: " + price.toString() + " руб.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                Text(salesNote,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue,
                ),
                FlatButton(child: Text("Купить товар "), onPressed: _launchURL),
              ],
            ),
          ),
        ]));
  }
}
