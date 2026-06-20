import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:laundry_jennaira/shared/models/transaction_model.dart';
import 'package:laundry_jennaira/core/utils/currency.dart';

class ExportHelper {
  static Future<String> exportMonthlyReportPdf(List<TransactionModel> transactions, String monthYear) async {
    // Request storage permissions
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    final pdf = pw.Document();

    int totalIncome = 0;
    int totalExpense = 0;

    final tableHeaders = ['Tanggal', 'Deskripsi', 'Tipe', 'Nominal (Rp)'];
    final tableData = transactions.map((t) {
      if (t.type == 'income') {
        totalIncome += t.amount;
      } else {
        totalExpense += t.amount;
      }

      final dateStr = t.createdAt.toIso8601String().split('T').first;
      final typeStr = t.type == 'income' ? 'Pemasukan' : 'Pengeluaran';
      final descStr = t.description ?? 'Transaksi';
      return [dateStr, descStr, typeStr, formatRupiah(t.amount)];
    }).toList();

    final netProfit = totalIncome - totalExpense;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Laporan Keuangan Laundry Jennaira - $monthYear',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.center,
                  3: pw.Alignment.centerRight,
                },
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total Laba Bersih: ${formatRupiah(netProfit)}',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save exactly to Android Documents
    final dir = Directory('/storage/emulated/0/Documents');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final safeMonthYear = monthYear.replaceAll('/', '_').replaceAll(' ', '_');
    final path = "${dir.path}/Laporan_Jennaira_$safeMonthYear.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    return path;
  }

  static Future<String> exportMonthlyReportCsv(List<TransactionModel> transactions, String monthYear) async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    final buffer = StringBuffer();
    buffer.writeln('Tanggal,Deskripsi,Tipe,Nominal (Rp)');

    int totalIncome = 0;
    int totalExpense = 0;

    for (var t in transactions) {
      if (t.type == 'income') {
        totalIncome += t.amount;
      } else {
        totalExpense += t.amount;
      }

      final dateStr = t.createdAt.toIso8601String().split('T').first;
      final typeStr = t.type == 'income' ? 'Pemasukan' : 'Pengeluaran';
      final descStr = '"${t.description ?? 'Transaksi'}"';
      
      buffer.writeln('$dateStr,$descStr,$typeStr,${t.amount}');
    }

    final netProfit = totalIncome - totalExpense;
    buffer.writeln(',,,');
    buffer.writeln(',,Total Pemasukan,$totalIncome');
    buffer.writeln(',,Total Pengeluaran,$totalExpense');
    buffer.writeln(',,Laba Bersih,$netProfit');

    final dir = Directory('/storage/emulated/0/Documents');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final safeMonthYear = monthYear.replaceAll('/', '_').replaceAll(' ', '_');
    final path = "${dir.path}/Laporan_Jennaira_$safeMonthYear.csv";
    final file = File(path);
    await file.writeAsString(buffer.toString());

    return path;
  }
}
