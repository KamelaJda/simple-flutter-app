import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/models/shop.dart';
import 'package:shoppinglist/utils/databaseutils.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();

}

class _ShopState extends State<CreateShop> {

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stwórz sklep'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nazwa sklepu (np. Biedronka)',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty || addressController.text.isEmpty) return;
                        DatabaseUtils.getNextId(Shop.tableName()).then((value) {
                          DatabaseUtils.insert(Shop(id: value, name: nameController.text, address: addressController.text))
                              .then((value) => Navigator.pop(context));
                        });
                      },
                      child: const Text("STWÓRZ SKLEP"),
                    )
                  ),
                ]
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

}