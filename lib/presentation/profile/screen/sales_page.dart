import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Melihat Penjualan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter berdasarkan waktu
            DropdownButton<String>(
              hint: Text('Pilih Waktu'),
              onChanged: (value) {
                // Logika untuk filter berdasarkan waktu
              },
              items: [
                DropdownMenuItem(value: 'Harian', child: Text('Harian')),
                DropdownMenuItem(value: 'Mingguan', child: Text('Mingguan')),
                DropdownMenuItem(value: 'Bulanan', child: Text('Bulanan')),
              ],
            ),

            SizedBox(height: 16),

            // Filter berdasarkan kategori tiket
            DropdownButton<String>(
              hint: Text('Pilih Kategori Tiket'),
              onChanged: (value) {
                // Logika untuk filter berdasarkan kategori
              },
              items: [
                DropdownMenuItem(value: 'VIP', child: Text('VIP')),
                DropdownMenuItem(value: 'Reguler', child: Text('Reguler')),
                DropdownMenuItem(value: 'Diskon', child: Text('Diskon')),
              ],
            ),

            SizedBox(height: 32),

            // Grafik Penjualan
            Text(
              'Grafik Penjualan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(showTitles: true),
                    leftTitles: SideTitles(showTitles: true),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 2),
                        FlSpot(2, 3),
                        FlSpot(3, 5),
                        FlSpot(4, 4),
                        FlSpot(5, 5),
                        FlSpot(6, 3),
                      ],
                      isCurved: true,
                      colors: [Colors.blue],
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Informasi Tambahan
            Text('Total Pembeli: 120', style: TextStyle(fontSize: 16)),
            Text('Waktu Lama Terjual: 3 Hari', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
