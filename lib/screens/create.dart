import 'package:flutter/cupertino.dart';

import '../models/Sepatu.dart';

enum FormMode { create, edit }

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key, required this.mode, this.sepatu});

  final FormMode mode;
  final Sepatu? sepatu;

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final TextEditingController _JumlahController = TextEditingController();
  final TextEditingController _MerkController = TextEditingController();
  final TextEditingController _UkuranController = TextEditingController();
  final TextEditingController _WarnaController = TextEditingController();
  final TextEditingController _JenisController = TextEditingController();
  final TextEditingController _JenisPelangganController =
      TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.edit) {
      _JumlahController.text = widget.sepatu!.Jumlah;
      _MerkController.text = widget.sepatu!.Merk;
      _UkuranController.text = widget.sepatu!.Ukuran;
      _WarnaController.text = widget.sepatu!.Warna;
      _JenisController.text = widget.sepatu!.Jenis;
      _JenisPelangganController.text = widget.sepatu!.JenisPelanggan;
    }
  }

  getSpt() {
    return Sepatu(
      Jumlah: _JumlahController.text,
      Merk: _MerkController.text,
      Ukuran: _UkuranController.text,
      Warna: _WarnaController.text,
      Jenis: _JenisController.text,
      JenisPelanggan: _JenisPelangganController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Data Sepatu'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.pop(context, getSpt());
          },
          child: Text(widget.mode == FormMode.create ? 'Tambah' : 'Edit'),
        ),
      ),
      child: SafeArea(
        child: CupertinoFormSection(
          header: Text(widget.mode == FormMode.create
              ? 'Tambah Data Sepatu'
              : 'Edit Data Sepatu'),
          children: [
            CupertinoFormRow(
              prefix: Text('Jumlah'),
              child: CupertinoTextFormFieldRow(
                controller: _JumlahController,
                placeholder: 'Masukkan Jumlah',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Merk'),
              child: CupertinoTextFormFieldRow(
                controller: _MerkController,
                placeholder: 'Masukkan Merk',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Ukuran'),
              child: CupertinoTextFormFieldRow(
                controller: _UkuranController,
                placeholder: 'Masukkan Ukuran',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Warna'),
              child: CupertinoTextFormFieldRow(
                controller: _WarnaController,
                placeholder: 'Masukkan Warna',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Jenis'),
              child: CupertinoTextFormFieldRow(
                controller: _JenisController,
                placeholder: 'Masukkan Jenis',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('JenisPelanggan'),
              child: CupertinoTextFormFieldRow(
                controller: _JenisPelangganController,
                placeholder: 'Masukkan JenisPelanggan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
