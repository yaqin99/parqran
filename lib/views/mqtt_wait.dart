import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parqran/model/mqtt_wrapper.dart';
import 'package:parqran/views/pengendara/mainMenu.dart';
import 'package:provider/provider.dart';

import '../model/person.dart';

class MqttWait extends StatefulWidget {
  const MqttWait({Key? key, required this.idParkir, required this.idKendaraan, required this.nomorKendaraan}) : super(key: key);

  final int idParkir;
  final int idKendaraan;
  final String nomorKendaraan;

  @override
  State<MqttWait> createState() => _MqttWaitState();
}

class _MqttWaitState extends State<MqttWait> {
  bool _isLoading = false;
  String message = '';
  late MQTTClientWrapper clientWrapper;
  bool _isPublished = false;
  int _idPengguna = 0;

  void show() {
    setState(() {
      _isLoading = true;
    });
  }

  void hide() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    clientWrapper = MQTTClientWrapper();
    clientWrapper.prepareMtqqtClient('parkir/${widget.idParkir}');
    clientWrapper.onMessageReceived = (String msg) {
      if (kDebugMode) {
        print('msg: $msg');
      }
      setState(() {
        message = msg;
      });
      
      Map<String, dynamic> data = json.decode(msg);
      if (data.containsKey('idPengguna')) {
        // jika diterima
        if (data['status'] == 'diterima') {
          // tampilkan dialog
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Pemberitahuan'),
                content: const Text('Kendaraan anda telah diterima. Silahkan masuk ke dalam parkir.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
          );
        }
        if (data['status'] == 'ditolak') {
          // tampilkan dialog
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Pemberitahuan'),
                content: const Text('Kendaraan anda ditolak. Silakan konfirmasi ke petugas parkir.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
          );
        }
      }
    };
    clientWrapper.onSubscribed = () {
      if (! _isPublished) {
        _idPengguna = Provider.of<Person>(context, listen: false).getIdPengguna;

        clientWrapper.publishMessage('parkir/${widget.idParkir}', jsonEncode({
          'idParkir': widget.idParkir,
          'idKendaraan': widget.idKendaraan,
          'idPengguna': _idPengguna,
          'nomorKendaraan': widget.nomorKendaraan,
          'status': 'waiting',
        }));
        _isPublished = true;
      }
    };

    Future.delayed(Duration.zero, () async {
      // show();
    });
    super.initState();
  }

  @override
  void dispose() {
    clientWrapper.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Menunggu Tanggapan Pemilik Parkir..',
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Opacity(opacity: 0.8, child: ModalBarrier(dismissible: false, color: Colors.black)),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}