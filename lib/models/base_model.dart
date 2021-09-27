abstract class BaseModel {
  final dynamic databaseId;
  Map<String, dynamic> toMap();

  BaseModel(this.databaseId);
}

