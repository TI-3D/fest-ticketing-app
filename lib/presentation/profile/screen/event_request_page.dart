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
        padding:
            const EdgeInsets.all(16.0), // memberikan padding agar lebih rapi
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController profileController = TextEditingController();

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

          // Email
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
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
            decoration: InputDecoration(
                labelText:
                    'Deskripsikan Profil Perusahaan, bisa sertakan Link Pendukung Profil Perusahaan'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Profil atau link website perusahaan tidak boleh kosong';
              }
              return null;
            },
          ),
          SizedBox(height: 24),

          // Tombol Submit
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Tampilkan konfirmasi pengiriman
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Request telah dikirim')),
                );

                // Clear form
                nameController.clear();
                emailController.clear();
                addressController.clear();
                profileController.clear();
              }
            },
            child:
                Text('Submit Request', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    profileController.dispose();
    super.dispose();
  }
}
