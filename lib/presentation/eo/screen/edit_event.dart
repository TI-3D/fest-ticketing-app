import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    // Mengisi form dengan data awal
    _titleController = TextEditingController(text: widget.initialTitle);
    _locationController = TextEditingController(text: widget.initialLocation);
    _descriptionController = TextEditingController(text: widget.initialDescription);
    _dateController = TextEditingController(text: widget.initialDate);
    _grades = List.from(widget.initialGrades);
    _selectedImages = List.from(widget.initialImages);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
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

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
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

  void _saveChanges() {
    // Simpan perubahan data acara
    final updatedEvent = {
      'title': _titleController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'grades': _grades,
      'images': _selectedImages.map((e) => e.path).toList(),
    };
    print('Updated Event: $updatedEvent');
    Navigator.pop(context, updatedEvent); // Kembalikan data yang telah diubah
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Event',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Photos*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length + 1,
                itemBuilder: (context, index) {
                  if (index == _selectedImages.length) {
                    return GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add_a_photo, color: Colors.grey),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(_selectedImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: GestureDetector(
                            onTap: () => _deleteImage(index),
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12,
                              child: Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Title*', _titleController, 'Event Title'),
            _buildTextField('Location*', _locationController, 'Event Location'),
            _buildTextField('Description*', _descriptionController, 'Event Description', maxLines: 3),
            _buildTextField('Date*', _dateController, 'dd/mm/yyyy'),
            const SizedBox(height: 16),
            const Text(
              'Price & Grade*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._grades.asMap().entries.map((entry) {
              final index = entry.key;
              final grade = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    _buildGradeField(index, 'grade', 'Grade', grade['grade']),
                    _buildGradeField(index, 'price', 'Price', grade['price']),
                    _buildGradeField(index, 'stock', 'Stock', grade['stock']),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteGrade(index),
                    ),
                  ],
                ),
              );
            }).toList(),
            TextButton(
              onPressed: _addNewGrade,
              child: const Text(
                '+ Add Grade',
                style: TextStyle(color: AppColor.primary),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          maxLines: maxLines,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGradeField(int index, String key, String hint, String? initialValue) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(hintText: hint),
        controller: TextEditingController(text: initialValue),
        onChanged: (value) => _updateGrade(index, key, value),
      ),
    );
  }
}
