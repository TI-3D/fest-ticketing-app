import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@festticket.com',
      queryParameters: {
        'subject': 'Support Request: ',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/+6282228035426');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'How can we help you?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find answers to common questions or contact our support team.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // Contact Support Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Support',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContactOption(
                      icon: Icons.email_outlined,
                      title: 'Email Support',
                      subtitle: 'Get help via email',
                      onTap: _launchEmail,
                    ),
                    const SizedBox(height: 12),
                    _buildContactOption(
                      icon: Icons.message,
                      title: 'WhatsApp Support',
                      subtitle: 'Chat with us on WhatsApp',
                      onTap: _launchWhatsApp,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // FAQ Section
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                context,
                question: 'How do I purchase tickets?',
                answer:
                    'To purchase tickets, simply browse available events, select your desired event, choose your tickets, and proceed to checkout with your preferred payment method.',
              ),
              _buildFAQItem(
                context,
                question: 'Can I get a refund?',
                answer:
                    'Refund policies vary by event. Generally, tickets are non-refundable unless the event is cancelled by the organizer. Please check the specific event\'s terms and conditions.',
              ),
              _buildFAQItem(
                context,
                question: 'How do I access my tickets?',
                answer:
                    'Your tickets can be accessed in the "My Tickets" section of the app. You can show the QR code at the venue for entry.',
              ),
              _buildFAQItem(
                context,
                question: 'Is my payment information secure?',
                answer:
                    'Yes, we use industry-standard encryption and secure payment gateways to protect your payment information.',
              ),

              // Troubleshooting Guide
              const SizedBox(height: 24),
              const Text(
                'Troubleshooting Guide',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTroubleshootingItem(
                title: 'Payment Issues',
                steps: [
                  'Check your internet connection',
                  'Verify your payment details',
                  'Ensure sufficient funds',
                  'Try a different payment method',
                ],
              ),
              _buildTroubleshootingItem(
                title: 'Ticket Display Problems',
                steps: [
                  'Refresh the app',
                  'Check your internet connection',
                  'Log out and log back in',
                  'Update the app to the latest version',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.red.shade700),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingItem({
    required String title,
    required List<String> steps,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...steps.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key + 1}. ',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(entry.value),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
