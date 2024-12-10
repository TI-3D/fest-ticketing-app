import 'package:fest_ticketing/presentation/category/screen/category.dart';
import 'package:fest_ticketing/presentation/product/screen/product_detail.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCategories = false;
  List<String> categories = [
    'Concert',
    'Exhibition',
    'Seminar',
    'Festival',
    'Workshop',
  ];

  // Variabel untuk menyimpan daftar kategori yang dipilih
  late List<String> selectedCategories;

  @override
  void initState() {
    super.initState();
    // Secara default, semua kategori terpilih (termasuk "All")
    selectedCategories = ['All'];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColor.primary,
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
                  color: Colors.grey[200],
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
                child: _buildCategories(),
              ),
            // daftar top event geser ke samping
            SliverToBoxAdapter(
              child: _buildSection(
                context: context,
                title: 'Top Event',
                albumCovers: const [
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                ],
                screenSize: screenSize,
              ),
            ),
            // daftar New event geser ke samping
            SliverToBoxAdapter(
              child: _buildSection(
                context: context,
                title: 'New Event',
                albumCovers: const [
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                  'assets/images/konser1.png',
                ],
                screenSize: screenSize,
              ),
            ),
            // daftar semua event dengan grid scroll ke bawah
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title "All" dan Button "See All"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Aksi ketika tombol "See All" ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryScreen(category: 'All'),
                              ),
                            );
                          },
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
                  // Grid untuk item "All"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5, // Replace with the actual item count
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Jumlah item per baris
                        crossAxisSpacing:
                            12, // Jarak antar item secara horizontal
                        mainAxisSpacing: 12, // Jarak antar item secara vertikal
                        childAspectRatio:
                            3 / 4, // Rasio lebar:tinggi untuk tiap card
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                title: 'Concert Title',
                                artist: 'Artist Name',
                                imagePath: 'assets/images/konser1.png',
                                price: [529000, 829000, 1029000] // Contoh harga
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    'assets/images/konser1.png',
                                    height: screenSize.height * 0.2,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Concert ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Artist ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'IDR 1,000,000',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
            ),
            SliverPadding(
                padding: EdgeInsets.only(bottom: padding.bottom + 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
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
          height: 40, // Tinggi tab horizontal
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              _buildCategoryTab('All'),
              for (final category in categories) _buildCategoryTab(category),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTab(String category) {
    final isSelected = selectedCategories.contains(category);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (category == 'All') {
            selectedCategories = isSelected ? [] : ['All'];
          } else {
            if (isSelected) {
              selectedCategories.remove(category);
            } else {
              selectedCategories.add(category);
            }

            if (selectedCategories.length == categories.length) {
              selectedCategories = ['All', ...categories];
            } else if (selectedCategories.isEmpty) {
              selectedCategories = ['All'];
            } else {
              selectedCategories.remove('All');
            }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColor.primary,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColor.primary,
              ),
            ),
          ),
        ),
      ),
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

    return Container(
      height: totalItemHeight + 50, // Add padding for section header
      color: Colors.white,
      child: Column(
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
                        price: [529000, 829000, 1029000],
                      ),
                    ),
                  ),
                  child: Container(
                    width: cardWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/konser1.png',
                            height: screenSize.height * 0.2,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Concert ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Artist ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'IDR 1,000,000',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
