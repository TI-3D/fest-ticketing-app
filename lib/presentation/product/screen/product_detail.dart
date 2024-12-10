import 'package:fest_ticketing/presentation/product/screen/checkout.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;
  final List<double> price;

  const ProductDetailScreen({
    Key? key,
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                          ],
                          stops: [0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Rentang harga
              Text(
                price.length > 1
                    ? 'Rp ${price[0].toStringAsFixed(0)} - Rp ${price[2].toStringAsFixed(0)}'
                    : 'Rp ${price[0].toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tiket Tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ticketRow('GA', 2000, 'Rp ${price[0].toStringAsFixed(0)}'),
                    _ticketRow(
                        'VIP', 1000, 'Rp ${price[1].toStringAsFixed(0)}'),
                    _ticketRow(
                        'VVIP', 500, 'Rp ${price[2].toStringAsFixed(0)}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Deskripsi artis
              const Text(
                'Tomorrow X Together, umumnya dikenal sebagai TXT, adalah grup vokal pria asal Korea Selatan yang dibentuk oleh Big Hit Music. Grup ini terdiri dari lima anggota, antara lain: Soobin, Yeonjun, Beomgyu, Taehyun dan HueningKai. Mereka debut pada 4 Maret 2019 dengan album mini The Dream Chapter: Star',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => _showBookingOptions(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _ticketRow(String type, int quantity, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: const TextStyle(fontSize: 14)),
          Text('$quantity', style: const TextStyle(fontSize: 14)),
          Text(price, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _showBookingOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        int quantity = 1;
        String selectedGrade = 'GA'; // Default grade
        double selectedPrice = price[0]; // Default price

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Buy Ticket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Grade',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: selectedGrade,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGrade = newValue!;
                            switch (selectedGrade) {
                              case 'GA':
                                selectedPrice = price[0];
                                break;
                              case 'VIP':
                                selectedPrice = price[1];
                                break;
                              case 'VVIP':
                                selectedPrice = price[2];
                                break;
                            }
                          });
                        },
                        items: <String>['GA', 'VIP', 'VVIP']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(
                              ticketClass: selectedGrade,
                              quantity: quantity,
                              price: selectedPrice * quantity,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Rp ${(selectedPrice * quantity).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
