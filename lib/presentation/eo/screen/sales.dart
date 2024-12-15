// import 'package:fest_ticketing/presentation/eo/screen/monthSelector.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class Sales extends StatefulWidget {
//   const Sales({super.key});

//   @override
//   State<Sales> createState() => _SalesState();
// }

// class _SalesState extends State<Sales> {
//   DateTime selectedMonth = DateTime.now();

//   void _handleMonthChange(DateTime newMonth) {
//     setState(() {
//       selectedMonth = newMonth;
//       _loadPerformanceData();
//     });
//   }

//   Future<void> _loadPerformanceData() async {
//     // Placeholder untuk logika pengambilan data performa
//     print('Load data untuk bulan: ${selectedMonth.month}-${selectedMonth.year}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(context),
//               const SizedBox(height: 20),
//               _buildMonthSelector(),
//               const SizedBox(height: 10),
//               _buildStatsRow(),
//               const SizedBox(height: 20),
//               _buildLineChart(),
//               const SizedBox(height: 20),
//               _buildSectionHeader('Top Event', null),
//               const SizedBox(height: 10),
//               _buildTopEventCard(),
//               const SizedBox(height: 20),
//               _buildSectionHeader('Detail Penjualan', () {
//                 // Placeholder untuk navigasi ke halaman detail
//                 print('View More pressed');
//               }),
//               const SizedBox(height: 10),
//               _buildSalesDetails(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         const Text(
//           'Your Performance',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget _buildMonthSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MonthSelector(
//           initialDate: selectedMonth,
//           onMonthSelected: _handleMonthChange,
//         )
//       ],
//     );
//   }

//   Widget _buildStatsRow() {
//     return Row(
//       children: [
//         _buildStatItem('Event', '1'),
//         const SizedBox(width: 20),
//         _buildStatItem('Ticket Terjual', '1,650'),
//         const SizedBox(width: 20),
//         _buildStatItem('Total Pendapatan', 'Rp 872,85 M'),
//       ],
//     );
//   }

//   Widget _buildLineChart() {
//     return Container(
//       height: 200,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   if (value == 0) return const Text('1 Sept');
//                   if (value == 29) return const Text('30 Sept');
//                   return const Text('');
//                 },
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 const FlSpot(0, 20),
//                 const FlSpot(5, 35),
//                 const FlSpot(10, 25),
//                 const FlSpot(15, 40),
//                 const FlSpot(20, 30),
//                 const FlSpot(25, 20),
//                 const FlSpot(29, 45),
//               ],
//               isCurved: true,
//               color: Colors.blue,
//               barWidth: 2,
//               dotData: FlDotData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback? action) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         if (action != null)
//           TextButton(
//             onPressed: action,
//             child: const Text(
//               'View More',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildTopEventCard() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Skate Jacket',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             '1,650 sold',
//             style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSalesDetails() {
//     return Expanded(
//       child: ListView.separated(
//         itemCount: 4,
//         separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
//         itemBuilder: (context, index) {
//           return _buildSalesDetailItem();
//         },
//       ),
//     );
//   }

//   Widget _buildSalesDetailItem() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           _buildDetailColumn('Nama', 'Dana'),
//           _buildDetailColumn('Ticket', 'Skate Jacket'),
//           _buildDetailColumn('Grade', 'VIP'),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailColumn(String label, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           const SizedBox(height: 4),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(String label, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           const SizedBox(height: 4),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  DateTime selectedMonth = DateTime.now();
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Data dummy untuk grafik
  final List<SalesData> dailySales = [
    SalesData(DateTime(2024, 3, 1), 150),
    SalesData(DateTime(2024, 3, 5), 280),
    SalesData(DateTime(2024, 3, 10), 200),
    SalesData(DateTime(2024, 3, 15), 350),
    SalesData(DateTime(2024, 3, 20), 250),
    SalesData(DateTime(2024, 3, 25), 180),
    SalesData(DateTime(2024, 3, 30), 400),
  ];

  void _handleMonthChange(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
      _loadPerformanceData();
    });
  }

  Future<void> _loadPerformanceData() async {
    // Placeholder untuk logika pengambilan data performa
    print(
        'Load data untuk bulan: ${selectedMonth.month}-${selectedMonth.year}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'Sales Performance',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMonthSelector(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsCards(),
          const SizedBox(height: 25),
          _buildChartSection(),
          const SizedBox(height: 25),
          _buildTopEventsSection(),
          const SizedBox(height: 25),
          _buildSalesDetailsSection(),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatCard(
            'Total Events',
            '15',
            Icons.event,
            Colors.blue,
          ),
          const Divider(height: 30),
          _buildStatCard(
            'Tickets Sold',
            '1,650',
            Icons.confirmation_number,
            Colors.green,
          ),
          const Divider(height: 30),
          _buildStatCard(
            'Total Revenue',
            currencyFormat.format(872850000),
            Icons.monetization_on,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Sales Trend',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() % 5 == 0) {
                          final date = dailySales[value.toInt()].date;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              DateFormat('dd MMM').format(date),
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: dailySales
                        .asMap()
                        .entries
                        .map((e) => FlSpot(
                              e.key.toDouble(),
                              e.value.sales.toDouble(),
                            ))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: Colors.blue,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                ],
                minX: 0,
                maxX: dailySales.length.toDouble() - 1,
                minY: 0,
                maxY: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopEventsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Performing Events',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildTopEventItem(
            'TXT World Tour',
            '1,250 tickets',
            'Rp 625.000.000',
            Colors.purple,
          ),
          const SizedBox(height: 15),
          _buildTopEventItem(
            'NewJeans Concert',
            '400 tickets',
            'Rp 247.850.000',
            Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildTopEventItem(
    String name,
    String tickets,
    String revenue,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.event, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  tickets,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            revenue,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Sales',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return _buildSaleItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'VIP Ticket - TXT World Tour',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rp 500.000',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                '2 min ago',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                selectedMonth = DateTime(
                  selectedMonth.year,
                  selectedMonth.month - 1,
                );
                _loadPerformanceData();
              });
            },
          ),
          Text(
            DateFormat('MMMM yyyy').format(selectedMonth),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                selectedMonth = DateTime(
                  selectedMonth.year,
                  selectedMonth.month + 1,
                );
                _loadPerformanceData();
              });
            },
          ),
        ],
      ),
    );
  }
}

// Model untuk data penjualan
class SalesData {
  final DateTime date;
  final double sales;

  SalesData(this.date, this.sales);
}

// Extension untuk memformat angka currency
extension CurrencyFormatting on num {
  String toCurrency() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}

// Custom Chart Legend
class ChartLegend extends StatelessWidget {
  final String label;
  final Color color;

  const ChartLegend({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// Custom Card untuk Detail Statistik
class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? trend;
  final bool isPositive;

  const StatisticCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trend!,
                        style: GoogleFonts.poppins(
                          color: isPositive ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
