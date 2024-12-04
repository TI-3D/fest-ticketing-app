import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().toString().split(' ')[0]}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Acceptance of Terms',
              'By accessing and using this e-ticketing application, you acknowledge '
                  'that you have read, understood, and agree to be bound by these Terms '
                  'and Conditions. If you do not agree with any part of these terms, '
                  'you may not use our services.',
            ),
            _buildSection(
              '2. User Registration',
              '• Users must provide accurate and complete information during registration\n'
                  '• Each user is limited to one account\n'
                  '• Users are responsible for maintaining the confidentiality of their account credentials\n'
                  '• Users must be at least 18 years old to create an account',
            ),
            _buildSection(
              '3. Ticket Purchase and Validity',
              '• All tickets purchased are for single use only\n'
                  '• Each user can purchase only one ticket per event/concert\n'
                  '• Tickets are non-transferable and non-refundable unless stated otherwise\n'
                  '• Digital tickets must be presented at the venue along with valid ID\n'
                  '• The organizer reserves the right to verify ticket authenticity',
            ),
            _buildSection(
              '4. Payment and Pricing',
              '• All prices are listed in the local currency and include applicable taxes\n'
                  '• Additional service fees may apply\n'
                  '• Payment must be made through approved payment methods\n'
                  '• Transactions are processed securely through our payment partners',
            ),
            _buildSection(
              '5. Cancellation and Refunds',
              '• Event cancellation by organizers will result in full refunds\n'
                  '• Refunds for cancelled events will be processed within 14 business days\n'
                  '• No refunds for user-initiated cancellations unless required by law\n'
                  '• Schedule changes may not qualify for refunds',
            ),
            _buildSection(
              '6. User Conduct',
              '• Users agree not to engage in ticket scalping or reselling\n'
                  '• Automated ticket purchasing is strictly prohibited\n'
                  '• Users must not attempt to circumvent any security measures\n'
                  '• Fraudulent activities will result in account termination',
            ),
            _buildSection(
              '7. Privacy and Data Protection',
              '• User data is collected and processed according to our Privacy Policy\n'
                  '• Personal information is secured using industry-standard encryption\n'
                  '• User data may be shared with event organizers when necessary\n'
                  '• Users can request data deletion as per applicable laws',
            ),
            _buildSection(
              '8. Intellectual Property',
              'All content within the application, including but not limited to logos, '
                  'designs, and software, is protected by intellectual property rights '
                  'and may not be reproduced without authorization.',
            ),
            _buildSection(
              '9. Liability Limitations',
              'The application is provided "as is" without warranties. We are not '
                  'liable for any indirect, incidental, or consequential damages arising '
                  'from the use of our services.',
            ),
            _buildSection(
              '10. Modifications',
              'We reserve the right to modify these terms at any time. Users will '
                  'be notified of significant changes, and continued use constitutes '
                  'acceptance of modified terms.',
            ),
            _buildSection(
              '11. Contact Information',
              'For questions or concerns regarding these terms, please contact our '
                  'support team at support@yourticketingapp.com',
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'I Understand and Accept',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
