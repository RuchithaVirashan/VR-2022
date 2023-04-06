import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../error.dart';

class GameQRView extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      if (validateQRData(scanData.code)) {
        // Valid data
        print('QR code data is valid: ${scanData.code}');
        result = scanData;
        controller.stopCamera();
      } else {
        // Invalid data
        print('QR code data is invalid: ${scanData.code}');
        controller.stopCamera();
        
      }
    });
  }

  bool validateQRData(String? qrText) {
    // Regular expression to validate the scanned data
    RegExp exp = RegExp(r"VRFOC23");
    return exp.hasMatch(qrText!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
              Center(
                child: Visibility(
                  visible: result == null ? true : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset('assets/scan_effect_ing.json',
                            animate: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: result != null
                    ? Text(
                        '${describeEnum(result!.format)} scanned successfully ${result!.code}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'scannig code',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
