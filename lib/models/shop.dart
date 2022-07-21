import 'idatabasemodel.dart';

class Shop extends IDatabaseModel {

  final int id;
  final String name;
  final String address;

  const Shop({
    required this.id,
    required this.name,
    required this.address
  });

  static Shop fromMap(Map<dynamic, dynamic> map) {
    return Shop(id: map['id'], name: map['name'], address: map['address']);
  }

  static String tableName() {
    return "shops";
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address
    };
  }

  @override
  String toString() {
    return 'Shop{id: $id, name: $name, address: $address}';
  }

  @override
  int getId() {
    throw id;
  }

  @override
  String getTableName() {
    return tableName();
  }

}