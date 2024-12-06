import 'package:fest_ticketing/presentation/eo/screen/monthSelector.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  DateTime selectedMonth = DateTime.now();

  void _handleMonthChange(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
      _loadPerformanceData();
    });
  }

  Future<void> _loadPerformanceData() async {
    // Placeholder untuk logika pengambilan data performa
    print('Load data untuk bulan: ${selectedMonth.month}-${selectedMonth.year}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildMonthSelector(),
              const SizedBox(height: 10),
              _buildStatsRow(),
              const SizedBox(height: 20),
              _buildLineChart(),
              const SizedBox(height: 20),
              _buildSectionHeader('Top Event', null),
              const SizedBox(height: 10),
              _buildTopEventCard(),
              const SizedBox(height: 20),
              _buildSectionHeader('Detail Penjualan', () {
                // Placeholder untuk navigasi ke halaman detail
                print('View More pressed');
              }),
              const SizedBox(height: 10),
              _buildSalesDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          'Your Performance',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MonthSelector(
          initialDate: selectedMonth,
          onMonthSelected: _handleMonthChange,
        )
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem('Event', '1'),
        const SizedBox(width: 20),
        _buildStatItem('Ticket Terjual', '1,650'),
        const SizedBox(width: 20),
        _buildStatItem('Total Pendapatan', 'Rp 872,85 M'),
      ],
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const Text('1 Sept');
                  if (value == 29) return const Text('30 Sept');
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 20),
                const FlSpot(5, 35),
                const FlSpot(10, 25),
                const FlSpot(15, 40),
                const FlSpot(20, 30),
                const FlSpot(25, 20),
                const FlSpot(29, 45),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback? action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (action != null)
          TextButton(
            onPressed: action,
            child: const Text(
              'View More',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildTopEventCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skate Jacket',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '1,650 sold',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesDetails() {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return _buildSalesDetailItem();
        },
      ),
    );
  }

  Widget _buildSalesDetailItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          _buildDetailColumn('Nama', 'Dana'),
          _buildDetailColumn('Ticket', 'Skate Jacket'),
          _buildDetailColumn('Grade', 'VIP'),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
