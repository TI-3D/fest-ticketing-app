import 'package:fest_ticketing/presentation/eo/screen/edit_event.dart';
import 'package:fest_ticketing/presentation/eo/screen/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/presentation/eo/screen/sales.dart';
import 'package:fest_ticketing/presentation/eo/screen/upload_event.dart';
import 'package:fest_ticketing/core/constant/color.dart';

class EventOrganizerScreen extends StatelessWidget {
  const EventOrganizerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        const AssetImage('assets/Images/profile.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Maafin Kreatif',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'maafin@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '081234567890',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadEventScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.upload, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sales(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bar_chart, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Event',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Event List Section
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Jumlah event, bisa diubah sesuai data
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(
                            title: 'TXT World Tour Act: Promise in Jkt',
                            artist: 'TXT',
                            imagePath: 'images/konser1.png',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'images/konser1.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'TXT World Tour Act: Promise in Jkt',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '22 Des - Jkt',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: const Text(
                                          'Scan Participant',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Menutup dialog
                                                    // Logika pemindaian menggunakan Face
                                                    print(
                                                        "Scan with Face selected");
                                                  },
                                                  icon: const Icon(Icons.face,
                                                      size: 40,
                                                      color: AppColor.primary),
                                                ),
                                                const Text('Face'),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Menutup dialog
                                                    // Logika pemindaian menggunakan Barcode
                                                    print(
                                                        "Scan with Barcode selected");
                                                  },
                                                  icon: const Icon(
                                                      Icons.qr_code_scanner,
                                                      size: 40,
                                                      color: AppColor.primary),
                                                ),
                                                const Text('Code'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red[50],
                                  backgroundColor: AppColor.primary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                    'Scan'), // This is the part that triggers the image picker
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Data event yang akan diedit
                                  final eventData = {
                                    'photo':
                                        'images/konser1.png', // Placeholder path gambar
                                    'title':
                                        'TXT World Tour Act: Promise in Jkt',
                                    'location': 'Jkt',
                                    'description': 'This is a description',
                                    'date': '22 Des',
                                    'grades': [
                                      {
                                        'grade': 'VIP',
                                        'price': '1,000,000',
                                        'stock': '100'
                                      },
                                      {
                                        'grade': 'Regular',
                                        'price': '500,000',
                                        'stock': '200'
                                      },
                                    ],
                                  };

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditEventScreen(eventData: eventData),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red[50],
                                  backgroundColor: AppColor.primary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigasi atau logika untuk Delete
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red[50],
                                  backgroundColor: AppColor.primary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ImagePickerScreen() {}
