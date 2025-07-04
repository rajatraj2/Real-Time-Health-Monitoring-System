import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PDFGenerator {
  static Future<void> generateAndSharePDF() async {
    final pdf = pw.Document();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('diagnosis_history')
        .orderBy('checked_at', descending: true)
        .get();

    final data = snapshot.docs.map((e) => e.data()).toList();

    // Header
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text("🧠 Health Diagnosis Report",
                style: const pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 10),
          data.isEmpty
              ? pw.Text("No diagnosis history available.")
              : pw.ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final entry = data[index];
                    final diagnosis = entry['diagnosis'] ?? 'Unknown';
                    final timestamp = entry['checked_at'] != null
                        ? (entry['checked_at'] as Timestamp)
                            .toDate()
                            .toLocal()
                            .toString()
                        : 'N/A';

                    return pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 6),
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(width: 1),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Diagnosis: $diagnosis",
                              style: const pw.TextStyle(fontSize: 14)),
                          pw.Text("Date: $timestamp",
                              style: const pw.TextStyle(fontSize: 10)),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );

    // Share PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'health_report.pdf',
    );
  }
}
