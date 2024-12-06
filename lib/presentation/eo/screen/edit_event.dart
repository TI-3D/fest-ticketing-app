import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';

class EditEventScreen extends StatefulWidget {
  final Map<String, dynamic> eventData; // Data event yang akan diedit

  const EditEventScreen({Key? key, required this.eventData}) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  List<Map<String, String>> _grades = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.eventData['title']);
    _locationController = TextEditingController(text: widget.eventData['location']);
    _descriptionController = TextEditingController(text: widget.eventData['description']);
    _dateController = TextEditingController(text: widget.eventData['date']);
    _grades = List<Map<String, String>>.from(widget.eventData['grades']);
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

  void _saveEvent() {
    // Logic untuk menyimpan perubahan
    final updatedEvent = {
      'title': _titleController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'grades': _grades,
    };
    print('Updated Event: $updatedEvent');
    Navigator.pop(context, updatedEvent); // Kirim data kembali
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'The title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Location*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'The location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'The description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Date*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
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
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Grade'),
                        controller: TextEditingController(text: grade['grade']),
                        onChanged: (value) => _updateGrade(index, 'grade', value),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Price'),
                        controller: TextEditingController(text: grade['price']),
                        onChanged: (value) => _updateGrade(index, 'price', value),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Stock'),
                        controller: TextEditingController(text: grade['stock']),
                        onChanged: (value) => _updateGrade(index, 'stock', value),
                      ),
                    ),
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
                '+ New Grade',
                style: TextStyle(color: AppColor.primary),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveEvent,
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
}
