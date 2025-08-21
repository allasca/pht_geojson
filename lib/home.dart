import 'package:flutter/material.dart';
import 'package:pht_geojson/controller.dart';
import 'package:flutter_json_view/flutter_json_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PHT GeoJSON')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  if (value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ValueListenableBuilder(
                    valueListenable: textJson,
                    builder: (context, value, child) {
                      if (value == '{}') {
                        return const Center(
                          child: Text('Tidak ada file yang dipilih'),
                        );
                      }
                      return JsonView.string(value);
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    FilledButton(
                      onPressed: () {
                        openFile();
                      },
                      child: const Text('Pilih File geoJSON'),
                    ),
                    Divider(),
                    FilledButton.tonal(
                      onPressed: () {
                        hapusNullDanZero();
                      },
                      child: const Text('Hapus data null dan 0'),
                    ),
                    Divider(),
                    TextField(
                      controller: namaFileBaru,
                      decoration: const InputDecoration(
                        labelText: 'Nama File Baru',
                        hintText: 'Masukkan nama file baru',
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        simpanFile();
                      },
                      child: const Text('Simpan File geoJSON'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
