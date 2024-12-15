// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fest_ticketing/core/constant/color.dart';

// class EditEventScreen extends StatefulWidget {
//   final String initialTitle;
//   final String initialLocation;
//   final String initialDescription;
//   final String initialDate;
//   final List<Map<String, String>> initialGrades;
//   final List<File> initialImages;

//   const EditEventScreen({
//     Key? key,
//     required this.initialTitle,
//     required this.initialLocation,
//     required this.initialDescription,
//     required this.initialDate,
//     required this.initialGrades,
//     required this.initialImages,
//   }) : super(key: key);

//   @override
//   State<EditEventScreen> createState() => _EditEventScreenState();
// }

// class _EditEventScreenState extends State<EditEventScreen> {
//   late TextEditingController _titleController;
//   late TextEditingController _locationController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _dateController;
//   late List<Map<String, String>> _grades;
//   late List<File> _selectedImages;

//   final ImagePicker _imagePicker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Mengisi form dengan data awal
//     _titleController = TextEditingController(text: widget.initialTitle);
//     _locationController = TextEditingController(text: widget.initialLocation);
//     _descriptionController = TextEditingController(text: widget.initialDescription);
//     _dateController = TextEditingController(text: widget.initialDate);
//     _grades = List.from(widget.initialGrades);
//     _selectedImages = List.from(widget.initialImages);
//   }

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
//     final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImages.add(File(pickedFile.path));
//       });
//     }
//   }

//   void _deleteImage(int index) {
//     setState(() {
//       _selectedImages.removeAt(index);
//     });
//   }

//   void _saveChanges() {
//     // Simpan perubahan data acara
//     final updatedEvent = {
//       'title': _titleController.text,
//       'location': _locationController.text,
//       'description': _descriptionController.text,
//       'date': _dateController.text,
//       'grades': _grades,
//       'images': _selectedImages.map((e) => e.path).toList(),
//     };
//     print('Updated Event: $updatedEvent');
//     Navigator.pop(context, updatedEvent); // Kembalikan data yang telah diubah
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
//           'Edit Event',
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
//             _buildTextField('Title*', _titleController, 'Event Title'),
//             _buildTextField('Location*', _locationController, 'Event Location'),
//             _buildTextField('Description*', _descriptionController, 'Event Description', maxLines: 3),
//             _buildTextField('Date*', _dateController, 'dd/mm/yyyy'),
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
//                     _buildGradeField(index, 'grade', 'Grade', grade['grade']),
//                     _buildGradeField(index, 'price', 'Price', grade['price']),
//                     _buildGradeField(index, 'stock', 'Stock', grade['stock']),
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
//                 onPressed: _saveChanges,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColor.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save Changes',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             filled: true,
//             fillColor: Colors.grey[100],
//           ),
//           maxLines: maxLines,
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildGradeField(int index, String key, String hint, String? initialValue) {
//     return Expanded(
//       child: TextField(
//         decoration: InputDecoration(hintText: hint),
//         controller: TextEditingController(text: initialValue),
//         onChanged: (value) => _updateGrade(index, key, value),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fest_ticketing/core/constant/color.dart';

class EditEventScreen extends StatefulWidget {
  final String initialTitle;
  final String initialLocation;
  final String initialDescription;
  final String initialDate;
  final List<Map<String, String>> initialGrades;
  final List<File> initialImages;

  const EditEventScreen({
    Key? key,
    required this.initialTitle,
    required this.initialLocation,
    required this.initialDescription,
    required this.initialDate,
    required this.initialGrades,
    required this.initialImages,
  }) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late List<Map<String, String>> _grades;
  late List<File> _selectedImages;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _locationController = TextEditingController(text: widget.initialLocation);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _dateController = TextEditingController(text: widget.initialDate);
    _grades = List.from(widget.initialGrades);
    _selectedImages = List.from(widget.initialImages);
  }

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
            _buildSaveButton(),
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
        'Edit Event',
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
            colors: [AppColor.primary, AppColor.primary],
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
          SizedBox(
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

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _saveChanges,
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
            const Icon(Icons.save_outlined, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Save Changes',
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

  // Helper methods
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

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Discard Changes?',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to discard all changes? This action cannot be undone.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Discard',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    // Validasi input
    if (_titleController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _selectedImages.isEmpty ||
        _grades.isEmpty) {
      _showValidationError();
      return;
    }

    // Simpan perubahan data acara
    final updatedEvent = {
      'title': _titleController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'grades': _grades,
      'images': _selectedImages.map((e) => e.path).toList(),
    };

    // Tampilkan dialog konfirmasi sukses
    _showSuccessDialog(updatedEvent);
  }

  void _showValidationError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Incomplete Information',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            'Please fill in all required fields and make sure to add at least one image and ticket category.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(Map<String, dynamic> updatedEvent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Success!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Text(
            'Event has been updated successfully.',
            style: GoogleFonts.poppins(),
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context,
                    updatedEvent); // Return to previous screen with updated data
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
