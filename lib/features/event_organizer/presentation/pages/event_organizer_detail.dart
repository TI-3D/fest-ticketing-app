import 'dart:io';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_failed.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_success.dart';
import 'package:fest_ticketing/features/event_organizer/data/models/event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/update_event_organizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/common/enitites/event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_organizer/event_organizer_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class EventOrganizerDetailPage extends StatelessWidget {
  final EventOrganizerEntity eventOrganizer;

  const EventOrganizerDetailPage({
    Key? key,
    required this.eventOrganizer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventOrganizerBloc, EventOrganizerState>(
      listener: (context, state) {
        if (state is EventOrganizerSuccess) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SuccessSnackBar(message: state.message!),
            );
          }
        } else if (state is EventOrganizerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            FailedSnackBar(message: state.message),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red.shade800,
                    Colors.red.shade600,
                    Colors.red.shade400,
                  ],
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // App Bar
                  BasicAppbar(
                    title: Text(
                      'Event Organizer Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Colors.white,
                  ),

                  // Profile and Details
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildProfileSection(),
                          _buildDetailsContainer(context),
                        ],
                      ),
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

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Iconsax.arrow_left_2, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Event Organizer Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: eventOrganizer.profilePicture != null
                ? NetworkImage(eventOrganizer.profilePicture!)
                : null,
            child: eventOrganizer.profilePicture == null
                ? Icon(
                    Iconsax.building,
                    size: 60,
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            eventOrganizer.companyName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildStatusChip(),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    String statusText;

    switch (eventOrganizer.status) {
      case EventOrganizerStatus.ACTIVE:
        chipColor = Colors.green;
        statusText = 'Active';
        break;
      case EventOrganizerStatus.PENDING:
        chipColor = Colors.orange;
        statusText = 'Pending';
        break;
      case EventOrganizerStatus.INACTIVE:
        chipColor = Colors.red;
        statusText = 'Inactive';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Contact Information'),
            const SizedBox(height: 16),
            _buildContactInfoCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Company Details'),
            const SizedBox(height: 16),
            _buildCompanyDetailsCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red.shade800,
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildInfoRow(Iconsax.sms, eventOrganizer.companyEmail),
          const Divider(),
          _buildInfoRow(Iconsax.call, eventOrganizer.companyPhone),
          const Divider(),
          _buildInfoRow(Iconsax.location, eventOrganizer.companyAddress),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade800, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            label: 'PIC Name',
            value: eventOrganizer.companyPic,
            maxLines: 1,
          ),
          const Divider(),
          _buildDetailRow(
            label: 'Experience',
            value: eventOrganizer.companyExperience,
            maxLines: 3,
          ),
          const Divider(),
          _buildDetailRow(
            label: 'Portfolio',
            value: eventOrganizer.companyPortfolio,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.4,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade200.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _showEditProfileBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade800,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Iconsax.edit_2, size: 24),
            SizedBox(width: 12),
            Text(
              'Edit Event Organizer Profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileBottomSheet(BuildContext context) {
    final TextEditingController companyNameController =
        TextEditingController(text: eventOrganizer.companyName);
    final TextEditingController companyPICController =
        TextEditingController(text: eventOrganizer.companyPic);
    final TextEditingController companyEmailController =
        TextEditingController(text: eventOrganizer.companyEmail);
    final TextEditingController companyPhoneController =
        TextEditingController(text: eventOrganizer.companyPhone);
    final TextEditingController companyAddressController =
        TextEditingController(text: eventOrganizer.companyAddress);
    final TextEditingController companyExperienceController =
        TextEditingController(text: eventOrganizer.companyExperience);
    final TextEditingController companyPortfolioController =
        TextEditingController(text: eventOrganizer.companyPortfolio);

    XFile? profilePicture;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.7,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.all(24),
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Edit Event Organizer Profile',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        setState(() {
                          profilePicture = pickedFile;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profilePicture != null
                              ? FileImage(File(profilePicture!.path))
                              : (eventOrganizer.profilePicture != null
                                  ? NetworkImage(eventOrganizer.profilePicture!)
                                  : null),
                          child: profilePicture == null &&
                                  eventOrganizer.profilePicture == null
                              ? Icon(
                                  Iconsax.camera,
                                  color: Colors.red.shade800,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade800,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Iconsax.camera,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildEditField(
                    label: 'Company Name', controller: companyNameController),
                const SizedBox(height: 16),
                _buildEditField(
                    label: 'Company PIC', controller: companyPICController),
                const SizedBox(height: 16),
                _buildEditField(
                  label: 'Company Email',
                  controller: companyEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildEditField(
                  label: 'Company Phone',
                  controller: companyPhoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildEditField(
                  label: 'Company Address',
                  controller: companyAddressController,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                _buildEditField(
                  label: 'Company Experience',
                  controller: companyExperienceController,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                _buildEditField(
                  label: 'Company Portfolio',
                  controller: companyPortfolioController,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade200.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final updateParams = UpdateEventOrganizerRequestParams(
                        organizerId: eventOrganizer.organizerId,
                        companyName: companyNameController.text,
                        companyPIC: companyPICController.text,
                        companyEmail: companyEmailController.text,
                        companyPhone: companyPhoneController.text,
                        companyAddress: companyAddressController.text,
                        companyExperience: companyExperienceController.text,
                        companyPortofolio: companyPortfolioController.text,
                        profilePicture: profilePicture,
                        profilePictureUrl: eventOrganizer.profilePicture ?? '',
                      );

                      // Call update use case
                      context
                          .read<EventOrganizerBloc>()
                          .add(EventOrganizerUpdate(updateParams));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
