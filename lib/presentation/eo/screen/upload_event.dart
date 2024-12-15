// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fest_ticketing/core/constant/color.dart';

// class UploadEventScreen extends StatefulWidget {
//   const UploadEventScreen({Key? key}) : super(key: key);

//   @override
//   State<UploadEventScreen> createState() => _UploadEventScreenState();
// }

// class _UploadEventScreenState extends State<UploadEventScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   List<Map<String, String>> _grades = [];
//   final List<File> _selectedImages = []; // List untuk menyimpan gambar yang dipilih

//   final ImagePicker _imagePicker = ImagePicker();

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _locationController.dispose();
//     _descriptionController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   void _addNewGrade() {
//     setState(() {
//       _grades.add({'grade': '', 'price': '', 'stock': ''});
//     });
//   }

//   void _updateGrade(int index, String key, String value) {
//     setState(() {
//       _grades[index][key] = value;
//     });
//   }

//   void _deleteGrade(int index) {
//     setState(() {
//       _grades.removeAt(index);
//     });
//   }

//   Future<void> _pickImage() async {
//     // Pilih gambar dari galeri
//     final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImages.add(File(pickedFile.path)); // Tambahkan gambar ke daftar
//       });
//     }
//   }

//   void _deleteImage(int index) {
//     setState(() {
//       _selectedImages.removeAt(index);
//     });
//   }

//   void _uploadEvent() {
//     // Logic untuk mengupload event baru
//     final newEvent = {
//       'title': _titleController.text,
//       'location': _locationController.text,
//       'description': _descriptionController.text,
//       'date': _dateController.text,
//       'grades': _grades,
//       'images': _selectedImages.map((e) => e.path).toList(), // Simpan path gambar
//     };
//     print('Uploaded Event: $newEvent');
//     Navigator.pop(context, newEvent); // Kirim data ke halaman sebelumnya
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Upload Event',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Photos*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _selectedImages.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == _selectedImages.length) {
//                     // Tombol untuk menambahkan gambar
//                     return GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         margin: const EdgeInsets.only(right: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(Icons.add_a_photo, color: Colors.grey),
//                       ),
//                     );
//                   } else {
//                     // Menampilkan gambar yang dipilih
//                     return Stack(
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 100,
//                           margin: const EdgeInsets.only(right: 8),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             image: DecorationImage(
//                               image: FileImage(_selectedImages[index]),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: 4,
//                           top: 4,
//                           child: GestureDetector(
//                             onTap: () => _deleteImage(index),
//                             child: const CircleAvatar(
//                               backgroundColor: Colors.red,
//                               radius: 12,
//                               child: Icon(Icons.close, size: 16, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Title*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 hintText: 'Event Title',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Location*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 hintText: 'Event Location',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Description*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 hintText: 'Event Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Date*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _dateController,
//               decoration: InputDecoration(
//                 hintText: 'dd/mm/yyyy',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Price & Grade*',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ..._grades.asMap().entries.map((entry) {
//               final index = entry.key;
//               final grade = entry.value;
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         decoration: const InputDecoration(hintText: 'Grade'),
//                         controller: TextEditingController(text: grade['grade']),
//                         onChanged: (value) => _updateGrade(index, 'grade', value),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: const InputDecoration(hintText: 'Price'),
//                         controller: TextEditingController(text: grade['price']),
//                         onChanged: (value) => _updateGrade(index, 'price', value),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         decoration: const InputDecoration(hintText: 'Stock'),
//                         controller: TextEditingController(text: grade['stock']),
//                         onChanged: (value) => _updateGrade(index, 'stock', value),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () => _deleteGrade(index),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//             TextButton(
//               onPressed: _addNewGrade,
//               child: const Text(
//                 '+ Add Grade',
//                 style: TextStyle(color: AppColor.primary),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _uploadEvent,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColor.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Upload Event',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadEventScreen extends StatefulWidget {
  const UploadEventScreen({Key? key}) : super(key: key);

  @override
  State<UploadEventScreen> createState() => _UploadEventScreenState();
}

class _UploadEventScreenState extends State<UploadEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, String>> _grades = [];
  final List<File> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePickerSection(),
            const SizedBox(height: 25),
            _buildFormSection(),
            const SizedBox(height: 25),
            _buildGradeSection(),
            const SizedBox(height: 30),
            _buildUploadButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 0,
      title: Text(
        'Create New Event',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primary,
              Color(0xFF6C63FF),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Photos',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length + 1,
              itemBuilder: (context, index) {
                if (index == _selectedImages.length) {
                  return _buildAddPhotoButton();
                }
                return _buildPhotoCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.primary.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColor.primary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Add Photo',
              style: GoogleFonts.poppins(
                color: AppColor.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard(int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: FileImage(_selectedImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 15,
          child: GestureDetector(
            onTap: () => _deleteImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField('Event Title', _titleController, Icons.event),
          const SizedBox(height: 20),
          _buildInputField(
              'Location', _locationController, Icons.location_on_outlined),
          const SizedBox(height: 20),
          _buildInputField(
              'Description', _descriptionController, Icons.description_outlined,
              maxLines: 3),
          const SizedBox(height: 20),
          _buildInputField(
              'Date', _dateController, Icons.calendar_today_outlined),
        ],
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, IconData icon,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColor.primary),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: AppColor.primary.withOpacity(0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket Categories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: _addNewGrade,
                icon: Icon(Icons.add_circle_outline, color: AppColor.primary),
                label: Text(
                  'Add Category',
                  style: GoogleFonts.poppins(color: AppColor.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ..._grades.asMap().entries.map((entry) {
            return _buildGradeCard(entry.key, entry.value);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGradeCard(int index, Map<String, String> grade) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: grade['grade']),
                  onChanged: (value) => _updateGrade(index, 'grade', value),
                  decoration: InputDecoration(
                    labelText: 'Grade',
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                onPressed: () => _deleteGrade(index),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: grade['price']),
                  onChanged: (value) => _updateGrade(index, 'price', value),
                  decoration: InputDecoration(
                    labelText: 'Price',
                    prefixText: 'Rp ',
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: grade['stock']),
                  onChanged: (value) => _updateGrade(index, 'stock', value),
                  decoration: InputDecoration(
                    labelText: 'Stock',
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, Color(0xFF6C63FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _uploadEvent,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_outlined, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Upload Event',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Keep existing helper methods (_pickImage, _deleteImage, etc.)
  void _addNewGrade() {
    setState(() {
      _grades.add({'grade': '', 'price': '', 'stock': ''});
    });
  }

  void _updateGrade(int index, String key, String value) {
    setState(() {
      _grades[index][key] = value;
    });
  }

  void _deleteGrade(int index) {
    setState(() {
      _grades.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _uploadEvent() {
    final newEvent = {
      'title': _titleController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'grades': _grades,
      'images': _selectedImages.map((e) => e.path).toList(),
    };
    print('Uploaded Event: $newEvent');
    Navigator.pop(context, newEvent);
  }
}
