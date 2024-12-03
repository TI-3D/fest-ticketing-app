import 'package:fest_ticketing/presentation/category/screen/category.dart';
import 'package:fest_ticketing/presentation/orders/screen/orders.dart';
import 'package:fest_ticketing/presentation/product/screen/product_detail.dart';
import 'package:fest_ticketing/presentation/profile/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCategories = false;
  // int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.search, size: 20),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.category,
                  color: AppColor.primary,
                  size: screenSize.width * 0.06,
                ),
                onPressed: () =>
                    setState(() => _showCategories = !_showCategories),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add refresh logic here
        },
        child: CustomScrollView(
          slivers: [
            if (_showCategories)
              SliverToBoxAdapter(
                child: _buildCategories(screenSize),
              ),
            SliverToBoxAdapter(
              child: _buildSection(
                context: context,
                title: 'Top Selling',
                albumCovers: const [
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                ],
                screenSize: screenSize,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSection(
                context: context,
                title: 'Near Your Location',
                albumCovers: const [
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                ],
                screenSize: screenSize,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSection(
                context: context,
                title: 'New In',
                albumCovers: const [
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                ],
                screenSize: screenSize,
              ),
            ),
            SliverPadding(
                padding: EdgeInsets.only(bottom: padding.bottom + 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(Size screenSize) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Add this
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.12,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this
                  children: [
                    CircleAvatar(
                      radius: screenSize.width * 0.06,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.music_note,
                        color: AppColor.primary,
                        size: screenSize.width * 0.05,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Category ${index + 1}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<String> albumCovers,
    required Size screenSize,
  }) {
    final cardWidth = screenSize.width * 0.4;
    final cardHeight = cardWidth * 1.3;
    final totalItemHeight = cardHeight + 40; // Image height + text space

    return SizedBox(
      height: totalItemHeight + 50, // Add padding for section header
      child: Column(
        mainAxisSize: MainAxisSize.min, // Add this
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(category: title),
                    ),
                  ),
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: albumCovers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        title: 'Concert Title',
                        artist: 'Artist Name',
                        imagePath: albumCovers[index],
                        price: 1000000, // Replace with actual price
                      ),
                    ),
                  ),
                  child: Container(
                    width: cardWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Add this
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            albumCovers[index],
                            width: cardWidth,
                            height: cardHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Concert Title',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Artist Name',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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
    );
  }
}
