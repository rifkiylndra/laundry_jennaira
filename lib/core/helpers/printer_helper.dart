import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';

class PrinterHelper {
  static Future<bool> isConnected() async {
    return await PrintBluetoothThermal.connectionStatus;
  }

  static Future<List<BluetoothInfo>> getPairedDevices() async {
    return await PrintBluetoothThermal.pairedBluetooths;
  }

  static Future<void> printReceipt(OrderModel order) async {
    bool connected = await isConnected();
    if (!connected) {
      throw Exception('Printer Bluetooth tidak terhubung');
    }

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    // Header
    bytes.addAll(generator.text(
      'LAUNDRY JENNAIRA',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    ));
    bytes.addAll(generator.text(
      'Jl. Contoh Alamat No. 123',
      styles: const PosStyles(align: PosAlign.center),
    ));
    bytes.addAll(generator.feed(1));

    // Info
    final dateStr = order.createdAt?.toIso8601String().split('T').first ?? '-';
    bytes.addAll(generator.text('Tanggal: $dateStr'));
    bytes.addAll(generator.text('Order ID: ${order.orderNo}'));
    bytes.addAll(generator.hr());

    // Item (Layanan tunggal per order di v1)
    final unit = order.service.toLowerCase() == 'satuan' ? 'Item' : 'Kg';
    bytes.addAll(generator.text(order.service));
    bytes.addAll(generator.row([
      PosColumn(
        text: '${order.weightKg} $unit',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatRupiah(order.price),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]));
    
    // Diskon jika ada
    if (order.discount > 0) {
      bytes.addAll(generator.row([
        PosColumn(
          text: 'Diskon',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '-${formatRupiah(order.discount)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]));
    }

    bytes.addAll(generator.hr());

    // Total
    final finalPrice = (order.price - order.discount).clamp(0, double.infinity).toInt();
    bytes.addAll(generator.row([
      PosColumn(
        text: 'Total:',
        width: 6,
        styles: const PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: formatRupiah(finalPrice),
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]));
    bytes.addAll(generator.feed(2));

    // Footer
    bytes.addAll(generator.text(
      'Terima kasih!',
      styles: const PosStyles(align: PosAlign.center),
    ));
    bytes.addAll(generator.feed(3));

    await PrintBluetoothThermal.writeBytes(bytes);
  }
}
