// File: lib/screens/disease_history_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/pdf_generator.dart';

class DiseaseHistoryScreen extends StatelessWidget {
  const DiseaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Disease History',
            style: TextStyle(color: Colors.black87)),
        backgroundColor: const Color(0xFFE0F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.black),
            tooltip: 'Export PDF',
            onPressed: () async {
              // await PDFGenerator.generateAndSharePDF();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Diagnoses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barGroups: [
                    BarChartGroupData(
                        x: 0,
                        barRods: [BarChartRodData(toY: 7, color: Colors.blue)]),
                    BarChartGroupData(
                        x: 1,
                        barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                    BarChartGroupData(
                        x: 2,
                        barRods: [BarChartRodData(toY: 9, color: Colors.blue)]),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Flu');
                            case 1:
                              return const Text('Cold');
                            case 2:
                              return const Text('Fever');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
