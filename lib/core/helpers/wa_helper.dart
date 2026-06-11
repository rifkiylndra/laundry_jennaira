import 'package:url_launcher/url_launcher.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';

class WaHelper {
  static Future<void> sendCustomerReceipt(String phone, OrderModel order) async {
    if (phone.isEmpty) {
      throw Exception('Nomor telepon pelanggan kosong');
    }

    String formattedPhone = phone;
    // Format to 62...
    if (formattedPhone.startsWith('0')) {
      formattedPhone = '62${formattedPhone.substring(1)}';
    } else if (formattedPhone.startsWith('+62')) {
      formattedPhone = formattedPhone.replaceAll('+', '');
    }

    final finalPrice = (order.price - order.discount).clamp(0, double.infinity).toInt();

    final message = '''
Halo, terima kasih telah menggunakan layanan Laundry Jennaira!

Berikut adalah rincian pesanan Anda:
*Order ID:* ${order.orderNo}
*Layanan:* ${order.service} (${order.service.toLowerCase() == 'satuan' ? '${order.weightKg.toInt()} Item' : '${order.weightKg} kg'})
*Total:* ${formatRupiah(finalPrice)}
*Status:* ${order.status}

Simpan pesan ini sebagai bukti pengambilan. Terima kasih!
''';

    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('whatsapp://send?phone=$formattedPhone&text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Aplikasi WhatsApp tidak ditemukan di perangkat ini');
    }
  }

  static Future<void> sendEndOfDayReport(String ownerPhone, Map<String, dynamic> summary) async {
    if (ownerPhone.isEmpty) {
      throw Exception('Nomor telepon Owner/Admin kosong');
    }

    String formattedPhone = ownerPhone;
    if (formattedPhone.startsWith('0')) {
      formattedPhone = '62${formattedPhone.substring(1)}';
    } else if (formattedPhone.startsWith('+62')) {
      formattedPhone = formattedPhone.replaceAll('+', '');
    }

    final totalCash = summary['totalCash'] ?? 0;
    final totalQris = summary['totalQris'] ?? 0;
    final totalExpense = summary['totalExpense'] ?? 0;
    final netProfit = (totalCash + totalQris) - totalExpense;

    final message = '''
*Laporan Tutup Buku Harian*
=========================
Pemasukan Tunai: ${formatRupiah(totalCash)}
Pemasukan QRIS: ${formatRupiah(totalQris)}
Total Pengeluaran: ${formatRupiah(totalExpense)}

*Laba Bersih:* ${formatRupiah(netProfit)}
''';

    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('whatsapp://send?phone=$formattedPhone&text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Aplikasi WhatsApp tidak ditemukan di perangkat ini');
    }
  }
}
