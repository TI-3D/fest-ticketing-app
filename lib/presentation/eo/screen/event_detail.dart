import 'package:fest_ticketing/presentation/eo/screen/edit_event.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'dart:io';

class EventDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;

  const EventDetailScreen({
    Key? key,
    required this.title,
    required this.artist,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Number of images
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('GA', style: TextStyle(fontSize: 14)),
                        Text('2000', style: TextStyle(fontSize: 14)),
                        Text('Rp 529.000', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('VIP', style: TextStyle(fontSize: 14)),
                        Text('1000', style: TextStyle(fontSize: 14)),
                        Text('Rp 829.000', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('VVIP', style: TextStyle(fontSize: 14)),
                        Text('500', style: TextStyle(fontSize: 14)),
                        Text('Rp 1.029.000', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tomorrow X Together, umumnya dikenal sebagai TXT, adalah grup vokal pria asal Korea Selatan yang dibentuk oleh Big Hit Music. Grup ini terdiri dari lima anggota, antara lain: Soobin, Yeonjun, Beomgyu, Taehyun dan HueningKai. Mereka debut pada 4 Maret 2019 dengan album mini The Dream Chapter: Star',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditEventScreen(
                  initialTitle: 'TXT World Tour Act: Promise in Jkt',
                  initialLocation: 'Jkt',
                  initialDescription: 'This is a description',
                  initialDate: '22 Des',
                  initialGrades: [
                    {'grade': 'VIP', 'price': '1,000,000', 'stock': '100'},
                    {'grade': 'Regular', 'price': '500,000', 'stock': '200'},
                  ],
                  initialImages: [
                    File('assets/images/konser1.png'),
                  ],
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Edit',
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
}
