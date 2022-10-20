import 'dart:convert';

import 'package:flutter_application_sepatu/screens/create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_sepatu/models/Sepatu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final storage = const FlutterSecureStorage();

  final List<Sepatu> _listSepatu = [];

  @override
  initState() {
    super.initState();
    _getDataFromStorage();
  }

  _getDataFromStorage() async {
    String? data = await storage.read(key: 'list_sepatu');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          _listSepatu.clear();
          for (var item in dataDecoded) {
            _listSepatu.add(Sepatu.fromJson(item));
          }
        });
      }
    }
  }

  _saveDataToStorage() async {
    final List<Object> tmp = [];
    for (var item in _listSepatu) {
      tmp.add(item.toJson());
    }

    await storage.write(
      key: 'list_sepatu',
      value: jsonEncode(tmp),
    );
  }

  _showPopupMenuItem(BuildContext context, int index) {
    final SepatuClicked = _listSepatu[index];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Menu untuk Sepatu ${SepatuClicked.Merk}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CreateEditScreen(
                    mode: FormMode.edit,
                    sepatu: SepatuClicked,
                  ),
                ),
              );
              if (result is Sepatu) {
                setState(() {
                  _listSepatu[index] = result;
                });
                _saveDataToStorage();
              }
            },
            child: const Text('Edit'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Yakin Ingin Menghapus?'),
                  content:
                      Text('Data Sepatu ${SepatuClicked.Merk} akan dihapus'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Tidak'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _listSepatu.removeAt(index);
                        });
                      },
                      child: const Text('Iya'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Data Sepatu'),
        trailing: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CreateEditScreen(
                  mode: FormMode.create,
                ),
              ),
            );
            if (result is Sepatu) {
              setState(() {
                _listSepatu.add(result);
              });
              _saveDataToStorage();
            }
          },
          child: Icon(
            CupertinoIcons.add_circled,
            size: 22,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: _listSepatu.length,
          itemBuilder: (context, index) {
            final item = _listSepatu[index];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () => _showPopupMenuItem(context, index),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.Jumlah} (${item.Merk})'),
                    Text(
                      '${item.JenisPelanggan} / ${item.Jenis} / ${item.Warna} / ${item.Ukuran}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
