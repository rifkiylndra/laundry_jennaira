import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';

class ExportHelper {
  static Future<String> exportMonthlyReport(List<TransactionModel> transactions, String monthYear) async {
    // CSV Header
    String csvData = "Tanggal,Deskripsi,Tipe,Metode Pembayaran,Jumlah\n";
    
    for (var t in transactions) {
      final dateStr = t.createdAt.toIso8601String().split('T').first;
      final typeStr = t.type == 'income' ? 'Pemasukan' : 'Pengeluaran';
      final methodStr = t.paymentMethod ?? '-';
      
      // Escape description if it has commas
      final descStr = (t.description?.contains(',') ?? false) ? '"${t.description}"' : (t.description ?? 'Transaksi');
      
      csvData += "$dateStr,$descStr,$typeStr,$methodStr,${t.amount}\n";
    }

    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      throw Exception('Tidak dapat menemukan direktori penyimpanan');
    }

    // Prepare filename safely
    final safeMonthYear = monthYear.replaceAll('/', '_').replaceAll(' ', '_');
    final path = "${directory.path}/Laporan_Jennaira_$safeMonthYear.csv";
    final file = File(path);
    await file.writeAsString(csvData);

    return path;
  }
}
