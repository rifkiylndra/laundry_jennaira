import 'package:url_launcher/url_launcher.dart';
import 'package:laundry_jennaira/shared/models/order_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final prefs = await SharedPreferences.getInstance();
    final shopName = prefs.getString('business_name') ?? 'Laundry Jennaira';
    final shopFooter = prefs.getString('business_footer') ?? 'Terima kasih!';

    final itemsSummaryList = order.items.map((item) {
      final isSatuan = item.serviceName != 'Cuci Gosok' &&
                       item.serviceName != 'Cuci Kering' &&
                       item.serviceName != 'Setrika';
      final unit = isSatuan ? 'Item' : 'kg';
      final weightOrQty = isSatuan ? item.weightOrQty.toInt().toString() : item.weightOrQty.toString();
      return '- ${item.serviceName} ($weightOrQty $unit): ${formatRupiah(item.price.round())}';
    }).join('\n');

    final message = '''
Halo, terima kasih telah menggunakan layanan $shopName!

Berikut adalah rincian pesanan Anda:
*Order ID:* ${order.orderNo}
*Detail Layanan:*
$itemsSummaryList
*Total:* ${formatRupiah(finalPrice)}
*Status:* ${order.status}

Simpan pesan ini sebagai bukti pengambilan. $shopFooter
''';

    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$formattedPhone?text=$encodedMessage');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception('Gagal membuka WhatsApp. Pastikan aplikasi terinstal.');
    }
  }

  static Future<void> sendEndOfDayReport(String ownerPhone, Map<String, dynamic> summary) async {
    String phoneToUse = ownerPhone;
    if (phoneToUse.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      phoneToUse = prefs.getString('business_phone') ?? '';
    }

    if (phoneToUse.isEmpty) {
      throw Exception('Nomor telepon Owner/Admin kosong');
    }

    String formattedPhone = phoneToUse;
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
    final url = Uri.parse('https://wa.me/$formattedPhone?text=$encodedMessage');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception('Gagal membuka WhatsApp. Pastikan aplikasi terinstal.');
    }
  }
}
