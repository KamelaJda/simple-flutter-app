abstract class IDatabaseModel {
  const IDatabaseModel();

  int getId();

  Map<String, dynamic> toMap();

  String getTableName();

}