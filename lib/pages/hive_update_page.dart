import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/pegawai.dart';

class HiveUpdatePage extends StatefulWidget {
  final String namePegawai;
  final int agePegawai;
  final int index;
  const HiveUpdatePage({
    super.key,
    required this.namePegawai,
    required this.agePegawai,
    required this.index,
  });

  @override
  State<HiveUpdatePage> createState() => _HiveUpdatePageState();
}

class _HiveUpdatePageState extends State<HiveUpdatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future<void> updateDataPegawai() async {
    final updateDataPegawai = await Hive.openBox('pegawai');

    String namePegawai = nameController.text;
    int agePegawai = int.parse(ageController.text);

    Pegawai updatePegawai = Pegawai(
      name: namePegawai,
      age: int.parse(agePegawai.toString()),
    );

    updateDataPegawai.putAt(widget.index, updatePegawai);
    nameController.clear();
    ageController.clear();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // Set nilai awal pada TextEditingController sesuai dengan data yang ingin di-update
    nameController.text = widget.namePegawai;
    ageController.text = widget.agePegawai.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Silahkan update data di sini!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width / 1.1,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: widget.namePegawai,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width / 1.1,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: InputDecoration(
                  hintText: widget.agePegawai.toString(),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateDataPegawai,
              child: const Text('update'),
            )
          ],
        ),
      ),
    );
  }
}
