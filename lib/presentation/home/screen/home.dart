import 'package:fest_ticketing/presentation/category/screen/category.dart';
import 'package:fest_ticketing/presentation/product/screen/product_detail.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCategories = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.category, color: Colors.red),
              onPressed: () {
                setState(() {
                  _showCategories = !_showCategories;
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showCategories) ...[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child:
                                const Icon(Icons.music_note, color: Colors.red),
                          ),
                          const SizedBox(height: 4),
                          Text('Category ${index + 1}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            _buildSection('Top Selling', [
              'assets/images/konser1.png',
              'assets/images/konser1.png',
            ]),
            _buildSection('Near Your Location', [
              'assets/images/konser1.png',
              'assets/images/konser1.png',
            ]),
            _buildSection('New In', [
              'assets/images/konser1.png',
              'assets/images/konser1.png',
            ]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> albumCovers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(category: title),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: albumCovers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        title: 'Concert Title',
                        artist: 'Artist Name',
                        imagePath: albumCovers[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        albumCovers[index],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 4),
                      const Text('Concert Title'),
                      const Text('Artist Name',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}