import 'package:flutter/material.dart';
import 'package:fest_ticketing/presentation/product/screen/product_detail.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 10, // Replace with actual item count
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    title: 'Concert ${index + 1}',
                    artist: 'Artist ${index + 1}',
                    imagePath: 'assets/images/konser1.png',
                    price: 1000000, // Replace with actual price
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/konser1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Concert ${index + 1}'),
                Text('Artist ${index + 1}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}