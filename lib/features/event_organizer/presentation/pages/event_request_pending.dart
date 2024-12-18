import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:iconsax/iconsax.dart';

class RequestEoPendingScreen extends StatelessWidget {
  const RequestEoPendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppbar(
        title: Text('Event Organizer Request'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(),
            const SizedBox(height: 16),
            _buildDescriptionText(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIllustration() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        'animations/icons8-pending.gif',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitleText() {
    return const Text(
      'Request Under Review',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDescriptionText() {
    return const Text(
      'Your Event Organizer application is being carefully reviewed by our team. '
      'We appreciate your patience during this process.\n\n'
      'Typical review time: 2-3 business days',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        height: 1.5,
      ),
    );
  }
}
