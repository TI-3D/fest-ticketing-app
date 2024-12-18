import 'package:camera/camera.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/common/enitites/event_class.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/services/camera_service.dart';
import 'package:fest_ticketing/features/liveness_detection/presentation/pages/user_detection.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EventDetailScreen extends StatelessWidget {
  final CameraService cameraService = CameraService()..initializeCameras();
  final EventEntity event;

  EventDetailScreen({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildEventDetails(context),
              const SizedBox(height: 80),
            ]),
          ),
        ],
      ),
      floatingActionButton: _buildActionButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildEventBackground(),
      ),
      leading: _buildLeadingButton(context),
    );
  }

  Widget _buildEventBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          event.image,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.9),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeadingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTitle(),
          const SizedBox(height: 8),
          _buildPriceRange(
              event.classes.whereType<EventClassEntity>().toList()),
          const SizedBox(height: 16),
          _buildTicketAvailableTable(),
          const SizedBox(height: 16),
          _buildDescriptionSection(),
        ],
      ),
    );
  }

  Widget _buildEventTitle() {
    return Text(
      event.name,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPriceRange(List<EventClassEntity> classes) {
    double minPrice =
        classes.map((c) => c.basePrice).reduce((a, b) => a < b ? a : b);
    double maxPrice =
        classes.map((c) => c.basePrice).reduce((a, b) => a > b ? a : b);

    return Text(
      minPrice == maxPrice
          ? 'Rp ${minPrice.toStringAsFixed(0)}'
          : 'Rp ${minPrice.toStringAsFixed(0)} - Rp ${maxPrice.toStringAsFixed(0)}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
    );
  }

  Widget _buildTicketAvailableTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Table(
        columnWidths: {
          0: const FlexColumnWidth(2),
          1: const FlexColumnWidth(1),
          2: const FlexColumnWidth(2),
        },
        children: [
          _buildTableHeader(),
          ...event.classes
              .map((c) => _buildTicketRow(
                  c?.className ?? 'Unknown', c?.count ?? 0, c?.basePrice ?? 0))
              .toList(),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      children: [
        _buildTableHeaderCell('Ticket Type'),
        _buildTableHeaderCell('Qty'),
        _buildTableHeaderCell('Price'),
      ],
    );
  }

  Widget _buildTableHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  TableRow _buildTicketRow(String type, int quantity, double price) {
    return TableRow(
      children: [
        _buildTableCell(type),
        _buildTableCell(quantity.toString()),
        _buildTableCell('Rp ${price.toStringAsFixed(0)}'),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          event.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Edit Button
          ElevatedButton.icon(
            onPressed: () => _showEditOptions(context),
            icon: const Icon(Iconsax.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(width: 16),
          // Scan Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserDetectionPage(
                        camera: cameraService.backCamera,
                        event_id: event.eventId)),
              );
            },
            icon: const Icon(Iconsax.scan),
            label: const Text('Scan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary.withOpacity(0.8), // 80% opacity
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Event',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Iconsax.edit_2),
                title: const Text('Edit Event Details'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EditEventScreen(event: event),
                  //   ),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.ticket),
                title: const Text('Manage Tickets'),
                onTap: () {
                  // Navigate to ticket management screen
                  Navigator.pop(context);
                  // Add navigation to ticket management screen
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
