import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  Widget build(BuildContext context) {
    String qrResult = 'Scanned data will appear here';
    Future<void> scanQR() async {
      try {
        final qrCode = await BarcodeScanner.scan();

        if (!mounted) return;

        setState(() {
          qrResult = qrCode.toString();
        });
      } on PlatformException {
        setState(() {
          qrResult = 'Failed to read QR code';
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Generate QR Code'),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              qrResult,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: scanQR, child: Text('Scan QR Code'))
          ],
        ))));
  }
}
