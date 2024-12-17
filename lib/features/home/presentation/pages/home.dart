import 'package:fest_ticketing/features/home/presentation/pages/category.dart';
import 'package:fest_ticketing/features/home/presentation/pages/product_detail.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/categories/categories_cubit.dart';
import 'package:fest_ticketing/features/home/presentation/bloc/event/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCategories = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<EventCubit>().fetchEvents();

    // Tambahkan listener untuk search
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Ambil teks pencarian saat ini
    final searchQuery = _searchController.text.toLowerCase();

    // Dapatkan state kategori saat ini
    final categoriesState = context.read<CategoriesCubit>().state;

    if (categoriesState is CategoryLoaded) {
      // Filter events berdasarkan kategori dan pencarian
      context.read<EventCubit>().filterEventsAndSearch(
            categories: categoriesState.selectedCategories.contains('All')
                ? categoriesState.allCategories
                : categoriesState.selectedCategories,
            searchQuery: searchQuery,
          );
    }
  }

  @override
  void dispose() {
    // Hapus controller saat widget di-dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return BlocListener<CategoriesCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          // Filter events berdasarkan kategori
          context.read<EventCubit>().filterEventsAndSearch(
                categories: state.selectedCategories.contains('All')
                    ? state.allCategories
                    : state.selectedCategories,
                searchQuery: _searchController.text.toLowerCase(),
              );
        }
      },
      child: Scaffold(
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
                        controller: _searchController, // Tambahkan controller
                        decoration: InputDecoration(
                          hintText: 'Search events...',
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: const Icon(Icons.search, size: 20),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                )
                              : null,
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
            // Refresh categories dan events
            context.read<CategoriesCubit>().fetchCategories();
            context.read<EventCubit>().fetchEvents();
          },
          child: CustomScrollView(
            slivers: [
              if (_showCategories)
                SliverToBoxAdapter(
                  child: _buildCategories(),
                ),
              // Top Event section
              SliverToBoxAdapter(
                child: _buildSection(
                  context: context,
                  title: 'Top Event',
                  screenSize: screenSize,
                ),
              ),
              // New Event section
              SliverToBoxAdapter(
                child: _buildSection(
                  context: context,
                  title: 'New Event',
                  screenSize: screenSize,
                ),
              ),
              // All Events Grid
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: BlocBuilder<EventCubit, EventState>(
                        builder: (context, state) {
                          if (state is EventLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is EventLoaded) {
                            final events = state.events;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: events.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 3 / 4,
                              ),
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return _buildEventGridItem(
                                    context, event, screenSize);
                              },
                            );
                          } else if (state is EventFailure) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                              child: Text("No events available"));
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
      ),
    );
  }

  // Method untuk build kategori
  Widget _buildCategories() {
    return BlocBuilder<CategoriesCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          final categories = state.allCategories;
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
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    _buildCategoryTab('All', state),
                    for (final category in categories)
                      _buildCategoryTab(category, state),
                  ],
                ),
              ),
            ],
          );
        } else if (state is CategoryFailure) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("No categories available"));
      },
    );
  }

  Widget _buildCategoryTab(String category, CategoryLoaded state) {
    final isSelected = state.selectedCategories.contains(category);

    return GestureDetector(
      onTap: () {
        context
            .read<CategoriesCubit>()
            .toggleCategory(category, state.allCategories);
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

  // Method untuk build section events (Top Event dan New Event)
  Widget _buildSection({
    required BuildContext context,
    required String title,
    required Size screenSize,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenSize.height * 0.4,
        minHeight: screenSize.height * 0.3,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
            child: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                if (state is EventLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EventLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      return _buildEventItem(
                          context, state.events[index], screenSize);
                    },
                  );
                } else if (state is EventFailure) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("No events available"));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method untuk build item event horizontal
  Widget _buildEventItem(BuildContext context, dynamic event, Size screenSize) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            event: event
          ),
        ),
      ),
      child: Container(
        width: screenSize.width * 0.4,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                event.image,
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.categories.first,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'IDR ${event.classes.first.basePrice}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method untuk build item event grid
  Widget _buildEventGridItem(
      BuildContext context, dynamic event, Size screenSize) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            event: event
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
              child: Image.network(
                event.image,
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
                    event.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.categories.first,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IDR ${event.classes.first.basePrice}',
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
  }
}
