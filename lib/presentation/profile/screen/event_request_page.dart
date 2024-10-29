import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Event Organizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // memberikan padding agar lebih rapi
        child: EventRequestForm(),
      ),
    );
  }
}

class EventRequestForm extends StatefulWidget {
  @override
  _EventRequestFormState createState() => _EventRequestFormState();
}

class _EventRequestFormState extends State<EventRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for other fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController profileController = TextEditingController();

  // Variable to store the selected image
  File? _posterImage;
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera
    if (pickedFile != null) {
      setState(() {
        _posterImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // Nama
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          
          // Alamat
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Alamat'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Alamat tidak boleh kosong';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          
          // Profil atau Link Website Perusahaan
          TextFormField(
            controller: profileController,
            decoration: InputDecoration(labelText: 'Profil atau Link Website Perusahaan'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Profil atau link website perusahaan tidak boleh kosong';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Kebutuhan Poster (Upload Gambar)
          Text(
            'Kebutuhan Poster',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _posterImage != null
              ? Image.file(_posterImage!)  // Display selected image preview
              : Text('Belum ada gambar yang dipilih'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Unggah Gambar'),
          ),
          SizedBox(height: 24),

          // Tombol Submit
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_posterImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Silakan unggah gambar poster')),
                  );
                  return;
                }

                // Tampilkan konfirmasi pengiriman
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Request telah dikirim')),
                );

                // Clear form
                nameController.clear();
                addressController.clear();
                profileController.clear();
                setState(() {
                  _posterImage = null;
                });
              }
            },
            child: Text('Submit Request'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    nameController.dispose();
    addressController.dispose();
    profileController.dispose();
    super.dispose();
  }
}
