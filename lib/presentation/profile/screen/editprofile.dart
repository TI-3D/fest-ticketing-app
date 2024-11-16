import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white, // Set entire background to white
      body: _buildBody(),
    );
  }

  // AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Edit Profile"),
      centerTitle: true,
      backgroundColor: Colors.red,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // Body
  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 16),
            _buildChangePictureButton(),
            const SizedBox(height: 24),
            _buildTextField(label: 'Name', initialValue: 'Muhamad Anang'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email', initialValue: 'anang123@gmail.com'),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone Number',
              initialValue: '081234567890',
            ),
            const SizedBox(height: 32),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Profile image
  Widget _buildProfileImage() {
    return Center(
      child: const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  // Change profile picture button
  Widget _buildChangePictureButton() {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          // Implement action to change profile picture
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey), // Add grey border
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: const Text(
          'Change Profile Picture',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  // Text field
  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Make the label bold
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black, // Ensure regular text style
          ),
          decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10), // Ensure padding throughout
          ),
        ),
      ],
    );
  }

  // Save Changes button
  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Save profile changes
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
