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
      ),body: SingleChildScrollView(
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
                            child: const Icon(Icons.music_note, color: Colors.red),
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
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'See All',
                style: TextStyle(color: Colors.red),
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
              return Padding(
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
                    const Text('Artist Name', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
  

  // Widget builder(BuildContext context, SearchController controller) {
  //   return TextField(
  //     controller: controller,
  //     decoration: const InputDecoration(
  //       hintText: 'Search...',
  //     ),
  //   );
  // }

  // List<Widget> suggestionsBuilder(
  //     BuildContext context, SearchController controller) {
  //   return <Widget>[
  //     ListTile(
  //       title: const Text('Suggestion 1'),
  //       onTap: () {
  //         controller.clear();
  //       },
  //     ),
  //     ListTile(
  //       title: const Text('Suggestion 2'),
  //       onTap: () {
  //         controller.clear();
  //       },
  //     ),
  //   ];
  // }

  // Widget _buildSection(String title, List<String> albumCovers) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style:
  //                   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             const Text(
  //               'See All',
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         height: 180,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: albumCovers.length,
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Image.asset(
  //                     albumCovers[index],
  //                     width: 120,
  //                     height: 120,
  //                     fit: BoxFit.cover,
  //                   ),
  //                   const SizedBox(height: 4),
  //                   const Text('Album Title'),
  //                   const Text('Artist Name',
  //                       style: TextStyle(color: Colors.grey)),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       title: Row(
  //         children: [
  //           InkWell(
  //             onTap: () {},
  //             child: CircleAvatar(
  //               backgroundColor: Colors.grey[200],
  //               child: const Icon(
  //                 Icons.person,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  //               child: TextField(
  //                 style: const TextStyle(
  //                     color: Colors.black), // Set text color to black
  //                 decoration: InputDecoration(
  //                   hintText: 'Search',
  //                   prefixIcon: const Icon(Icons.search),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(30),
  //                     borderSide: BorderSide.none,
  //                   ),
  //                   filled: true,
  //                   fillColor: Colors.grey[200],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.category_rounded),
  //             onPressed: () {
  //               setState(() {
  //                 _showCategories = !_showCategories;
  //               });
  //             },
  //             color: Colors.grey,
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Text(
  //               'Categories',
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 100,
  //             child: ListView(
  //               scrollDirection: Axis.horizontal,
  //               children: List.generate(
  //                 5,
  //                 (index) => Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Column(
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 30,
  //                         backgroundColor: Colors.grey[300],
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text('Category ${index + 1}'),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           _buildSection('Top Selling', [
  //             'assets/album1.jpg',
  //             'assets/album2.jpg',
  //           ]),
  //           _buildSection('Near Your Location', [
  //             'assets/album3.jpg',
  //             'assets/album4.jpg',
  //           ]),
  //           _buildSection('New In', [
  //             'assets/album5.jpg',
  //             'assets/album6.jpg',
  //           ]),
  //         ],
  //       ),
  //     ),
  //   );
  // }
