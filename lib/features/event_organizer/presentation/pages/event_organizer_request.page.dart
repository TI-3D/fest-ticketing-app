import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_organizer/event_organizer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class EventOrganizerRequestPage extends StatelessWidget {
  const EventOrganizerRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text('Apply as Event Organizer'),
      ),
      body: const EventOrganizerRequestForm(),
    );
  }
}

class EventOrganizerRequestForm extends StatefulWidget {
  const EventOrganizerRequestForm({Key? key}) : super(key: key);

  @override
  _EventOrganizerRequestFormState createState() =>
      _EventOrganizerRequestFormState();
}

class _EventOrganizerRequestFormState extends State<EventOrganizerRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _companyNameController = TextEditingController();
  final _picNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _experienceController = TextEditingController();
  final _portofolioLinkController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    _companyNameController.dispose();
    _picNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _experienceController.dispose();
    _portofolioLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildCompanyNameField(),
            const SizedBox(height: 16),
            _buildPICNameField(),
            const SizedBox(height: 16),
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPhoneField(),
            const SizedBox(height: 16),
            _buildAddressField(),
            const SizedBox(height: 16),
            _buildExperienceField(),
            const SizedBox(height: 16),
            _buildPortofolioLinkField(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyNameField() {
    return TextFormField(
      controller: _companyNameController,
      decoration: _inputDecoration(
        labelText: 'Company/Agency Name',
        prefixIcon: Iconsax.building,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter company name';
        }

        if (value.length < 5) {
          return 'Please  enter a valid company name';
        }
        return null;
      },
    );
  }

  Widget _buildPICNameField() {
    return TextFormField(
      controller: _picNameController,
      decoration: _inputDecoration(
        labelText: 'Person in Charge (PIC) Name',
        prefixIcon: Iconsax.user,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter PIC name';
        }

        if (value.length < 5) {
          return 'Please enter a valid name';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration(
        labelText: 'Contact Email',
        prefixIcon: Iconsax.sms,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter contact email';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: _inputDecoration(
        labelText: 'Contact Phone Number',
        prefixIcon: Iconsax.call,
      ),
      onChanged: (value) {
        if (value.isNotEmpty && !RegExp(r'[0-9]').hasMatch(value)) {
          _phoneController.text = value.substring(0, value.length - 1);
          return;
        }
        if (value.isNotEmpty) {
          if (value[0] != '0') {
            _phoneController.text = '0' + value;
            _phoneController.selection = TextSelection.fromPosition(
              TextPosition(offset: _phoneController.text.length),
            );
          }
        }

        if (value.length > 13) {
          _phoneController.text = value.substring(0, 13);
          _phoneController.selection = TextSelection.fromPosition(
            TextPosition(offset: _phoneController.text.length),
          );
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter contact phone number';
        }
        final phoneRegex = RegExp(r'^[0-9]{10,13}$');
        if (!phoneRegex.hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      maxLines: 3,
      decoration: _inputDecoration(
        labelText: 'Company Address',
        prefixIcon: Iconsax.map,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter company address';
        }

        if (value.length < 20) {
          return 'Please provide more detailed address';
        }
        return null;
      },
    );
  }

  Widget _buildExperienceField() {
    return TextFormField(
      controller: _experienceController,
      maxLines: 4,
      decoration: _inputDecoration(
        labelText: 'Experience in Event Management',
        prefixIcon: Iconsax.briefcase,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please describe your experience';
        }

        if (value.length < 50) {
          return 'Please provide more detailed experience';
        }
        return null;
      },
    );
  }

  Widget _buildPortofolioLinkField() {
    return TextFormField(
      controller: _portofolioLinkController,
      decoration: _inputDecoration(
        labelText: 'Portofolio/Website Link',
        prefixIcon: Iconsax.link,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your portofolio link';
        }

        // Check if the entered link is a valid URL
        final urlRegex = RegExp(
          r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
        );
        if (!urlRegex.hasMatch(value)) {
          return 'Please enter a valid URL';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIcon, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade800, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitRequest,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade800,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.send, color: Colors.white),
          SizedBox(width: 8),
          Text('Submit Application', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      // Logic to send data to server or database
      BlocProvider.of<EventOrganizerBloc>(context)
          .add(EventOrganizerCreate(CreateEventOrganizerRequestParams(
        companyName: _companyNameController.text,
        companyPIC: _picNameController.text,
        companyEmail: _emailController.text,
        companyPhone: _phoneController.text,
        companyAddress: _addressController.text,
        companyExperience: _experienceController.text,
        companyPortofolio: _portofolioLinkController.text,
      )));
      // Show success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Application submitted successfully!')),
      // );

      // Clear form after submission
      // _formKey.currentState!.reset();
      // _companyNameController.clear();
      // _picNameController.clear();
      // _emailController.clear();
      // _phoneController.clear();
      // _addressController.clear();
      // _experienceController.clear();
      // _portofolioLinkController.clear();
    }
  }
}
