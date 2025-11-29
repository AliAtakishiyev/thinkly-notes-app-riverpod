import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  DateTime? date;

  @HiveField(3)
  DateTime? edittedDate;

  Note({required this.title, required this.description, required this.date});
}
