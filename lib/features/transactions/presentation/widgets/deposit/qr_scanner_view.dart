import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../core/theme/app_theme.dart';

class QrScannerView extends StatefulWidget {
  final Function(String code) onScan;

  const QrScannerView({super.key, required this.onScan});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  // متغير لمنع التكرار السريع جداً قبل أن تختفي الويدجت
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.navy.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: false,
            ),
            onDetect: (capture) {
              if (isScanned) return; // منع التكرار

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  setState(() => isScanned = true); // قفل الماسح
                  widget.onScan(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          // Overlay (تغميق وتصميم)
          Container(color: Colors.black.withOpacity(0.3)),

          // الإطار الذهبي
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.gold, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Container(
                  height: 1,
                  width: 200,
                  color: Colors.redAccent.withOpacity(0.5)
              ),
            ),
          ),

          // نص التوجيه
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Align QR code within frame",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}