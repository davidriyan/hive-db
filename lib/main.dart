import 'package:flutter/material.dart';
import 'package:hive_db/model/pegawai.dart';
import 'package:hive_db/pages/hive_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathprovider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
//! melakukan register adapter, agar data di adapter dapat digunakan
  Hive.registerAdapter(PegawaiAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const HivePage(),
    );
  }
}
