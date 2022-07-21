import 'package:flutter/material.dart';
import 'package:shoppinglist/routes/createshop.dart';
import '../models/idatabasemodel.dart';
import '../models/shop.dart';
import '../utils/databaseutils.dart';

class ShopsList extends StatefulWidget {
  const ShopsList({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<ShopsList> {

  List<Shop> shops = [];

  @override
  void initState() {
    List<Shop> finalList = [];
    Future<List<IDatabaseModel?>> list = DatabaseUtils.retrieveAll(Shop.tableName(), (i) {
      return Shop.fromMap(i);
    });

    list.then((value) {
      for (var element in value) {
        finalList.add(element as Shop);
      }
      setState(() => shops = finalList);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twoje sklepy'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var value in shops)
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: InkWell(
                            child: SizedBox(
                              height: 125,
                              child: Center(child: Text(value.name)),
                            ),
                            onTap: () {

                            },
                          )
                      ),
                  ]
              )
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateShop()),
          );
        },
        tooltip: 'Dodaj sklep',
        child: const Icon(Icons.add),
      ),
    );
  }

}