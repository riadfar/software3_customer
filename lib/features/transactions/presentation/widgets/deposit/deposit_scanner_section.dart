import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../core/theme/app_theme.dart';

enum ScanState { scanning, processing, error }

class DepositScannerSection extends StatefulWidget {
  final Function(String ref, String amount) onCodeScanned;

  const DepositScannerSection({super.key, required this.onCodeScanned});

  @override
  State<DepositScannerSection> createState() => _DepositScannerSectionState();
}

class _DepositScannerSectionState extends State<DepositScannerSection> {
  ScanState _scanState = ScanState.scanning;

  @override
  Widget build(BuildContext context) {
    switch (_scanState) {
      case ScanState.scanning:
        return _buildCameraView();
      case ScanState.processing:
        return _buildLoadingView();
      case ScanState.error:
        return _buildErrorView();
    }
  }

  Widget _buildCameraView() {
    return Container(
      height: 350,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppTheme.navy.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _processScannedCode(barcode.rawValue!);
                  break;
                }
              }
            },
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          Container(
            width: 220, height: 220,
            decoration: BoxDecoration(border: Border.all(color: AppTheme.gold, width: 2), borderRadius: BorderRadius.circular(20)),
            child: Center(child: Container(height: 1, width: 200, color: Colors.redAccent.withOpacity(0.5))),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
              child: const Text("Align QR code within frame", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      height: 350,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppTheme.navy),
            SizedBox(height: 16),
            Text("Verifying QR Code...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          const Text("Invalid QR Format", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 8),
          const Text("Please scan a valid bill.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => setState(() => _scanState = ScanState.scanning),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text("Try Again"),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.navy, foregroundColor: Colors.white),
          )
        ],
      ),
    );
  }

  Future<void> _processScannedCode(String code) async {
    setState(() => _scanState = ScanState.processing);
    await Future.delayed(const Duration(milliseconds: 800)); // محاكاة

    final RegExp qrPattern = RegExp(r'^REF-[a-zA-Z0-9]+:\d+(\.\d{1,2})?$');

    if (qrPattern.hasMatch(code)) {
      final parts = code.split(':');
      final cleanRef = parts[0].substring(4);
      final amount = parts[1];
      widget.onCodeScanned(cleanRef, amount); // النجاح: إرسال البيانات للأب
    } else {
      setState(() => _scanState = ScanState.error);
    }
  }
}