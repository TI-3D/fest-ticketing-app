import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        elevation: 0,
        title: const Text(
          'Ticket Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(

          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'TXT World Tour Act: Promise in Jakarta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // deskripsi
              const Text(
                'Watching TXT World Tour Act performance on their Southeast Asia tour at Istora Senayan, Jakarta, December 28 2022. Buy concert tickets for the FestTicket SOUTHEAST ASIA TOUR in Jakarta',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.location_on, color: Colors.grey),
                  Text(
                    'Istora Senayan, Jakarta',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '22 Desember 2024\n20:00 - ends',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.grey),

              _buildTicketInfoRow('Name', 'Anang'),
              _buildTicketInfoRow('Grade', 'VIP'),
              _buildTicketInfoRow('Amount', '1'),
              _buildTicketInfoRow('Payment', 'Dana'),
              _buildTicketInfoRow('Total', 'Rp 1.000.000', isBold:true),
              const SizedBox(height: 24),

              // barcode
              Image.asset(
                '/images/barcode.png', 
                height: 80,
              ),
              const SizedBox(height: 16),

              // save button
              ElevatedButton(
                onPressed: () {
                  // Logika untuk menyimpan ke galeri
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save to Gallery',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
