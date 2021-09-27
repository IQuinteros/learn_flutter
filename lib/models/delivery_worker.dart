import 'package:learn_flutter/models/base_model.dart';

class DeliveryWorker extends BaseModel{
  final String name;
  final String lastName;

  DeliveryWorker({
    dynamic databaseId,
    required this.name, 
    required this.lastName
  }) : super(databaseId);

  @override
  Map<String, dynamic> toMap() => {
    'name': name,
    'lastName': lastName
  };

  factory DeliveryWorker.fromMap(dynamic id, Map<String,dynamic> map) => DeliveryWorker(
    databaseId: id,
    name: map['name'],
    lastName: map['lastName']
  );

  
}