import 'package:flutter/material.dart';
import 'package:hive_db/model/pegawai.dart';
import 'package:hive_db/pages/hive_insert.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_db/pages/hive_update_page.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Data Pegawai'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final dataUpdate = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HiveInsertPage();
                  },
                ),
              );
              if (dataUpdate == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Hive.openBox('pegawai'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataPegawai = Hive.box('pegawai');
            //! mengecek data kosong atau tidak
            if (dataPegawai.length == 0) {
              return const Center(
                child: Text(
                  'Data kosong nih',
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
            //! jika data ada, maka akan mengembalikan
            return ValueListenableBuilder(
              valueListenable: dataPegawai.listenable(),
              builder: (context, box, _) {
                return ListView.builder(
                  itemCount: dataPegawai.length,
                  itemBuilder: (context, index) {
                    Pegawai pegawai = dataPegawai.getAt(index);
                    // print(pegawai.listRiwayatPegawai);
                    return ListTile(
                      title: Text(pegawai.name),
                      subtitle: Text(pegawai.age.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          dataPegawai.deleteAt(index);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HiveUpdatePage(
                                namePegawai: pegawai.name,
                                agePegawai: int.parse(pegawai.age.toString()),
                                index: index,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
