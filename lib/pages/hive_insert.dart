import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/model/pegawai.dart';

class HiveInsertPage extends StatefulWidget {
  const HiveInsertPage({super.key});

  @override
  State<HiveInsertPage> createState() => _HiveInsertPageState();
}

class _HiveInsertPageState extends State<HiveInsertPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Fungsi untuk menambahkan pegawai ke dalam box
  Future<void> addPegawai() async {
    final dataPegawai = await Hive.openBox('pegawai');

    // Ambil nilai dari TextField
    String name = nameController.text;
    int age = int.parse(ageController.text);

    // Buat objek Pegawai baru
    Pegawai newPegawai = Pegawai(
      name: name,
      age: int.parse(age.toString()),
    );

    // Tambahkan Pegawai ke dalam box
    dataPegawai.add(newPegawai);

    // Kosongkan nilai TextField setelah menambahkan pegawai
    nameController.clear();
    ageController.clear();

    // ignore: use_build_context_synchronously
    Navigator.pop(context, true);
    // Refresh halaman
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Silahkan tambah data di sini!',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width / 1.1,
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama pegawai',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width / 1.1,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: ageController,
              decoration: const InputDecoration(
                hintText: 'Masukkan umur pegawai',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: addPegawai,
            child: const Text('Submit'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
