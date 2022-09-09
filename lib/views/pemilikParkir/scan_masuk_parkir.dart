import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parqran/views/pemilikParkir/PemilikParkirMenu.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanMasukParkir extends StatefulWidget {
  const ScanMasukParkir({Key? key}) : super(key: key);

  @override
  State<ScanMasukParkir> createState() => _ScanMasukParkirState();
}

class _ScanMasukParkirState extends State<ScanMasukParkir> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            //horizontal list to pick kendaraan
            const BottomInfo(),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.flipCamera();
    controller.flipCamera();
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      
      try {
        var resp = await Dio().post('${dotenv.env['API']!}/parking/here', data: {
          // 'id_parkiran': data['idParkir'],
          // 'id_pengguna': data['idPengguna'],
          // 'id_kendaraan': data['idKendaraan']
        });
        // anggep tersimpan
        if (kDebugMode) {
          print('msg: ${resp.data}');
        }
        // muncullkan dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Kendaraan berhasil masuk'),
            actions: [
              TextButton(
                onPressed: () {
                  /// SEMENTARA redirect ke PemilikParkirMenu
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PemilikParkirMenu()));
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print('msg: error: $e');
        }
      }
    });
  }
}

/// Bottom info widget
class BottomInfo extends StatelessWidget {
  const BottomInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Scan QR Code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Scan QR Code kendaraan yang akan masuk',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}