import 'package:hive/hive.dart';

part 'pegawai.g.dart';

@HiveType(typeId: 1)
class Pegawai {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;

  Pegawai({required this.name, required this.age});
}
