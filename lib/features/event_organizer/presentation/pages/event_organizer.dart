import 'package:fest_ticketing/common/widgets/snackbar/snackbar_failed.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_success.dart';
import 'package:fest_ticketing/features/event_organizer/data/models/event_organizer.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/pages/event_organizer_dashboard.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/pages/event_organizer_request.page.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/pages/event_request_pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_organizer/event_organizer_bloc.dart';

class EventOrganizerScreen extends StatelessWidget {
  const EventOrganizerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger the event to get the organizer
    context.read<EventOrganizerBloc>().add(EventOrganizerGet());

    return Scaffold(
      body: BlocListener<EventOrganizerBloc, EventOrganizerState>(
        listener: (context, state) {
          if (state is EventOrganizerFailure) {
            // Show Snackbar when there is a failure
            ScaffoldMessenger.of(context).showSnackBar(
              FailedSnackBar(message: state.message),
            );
          }

          if (state is EventOrganizerSuccess) {
            // Show Snackbar when the organizer is successfully fetched
            ScaffoldMessenger.of(context).showSnackBar(
              SuccessSnackBar(message: 'Event Organizer fetched'),
            );
          }
        },
        child: BlocBuilder<EventOrganizerBloc, EventOrganizerState>(
          builder: (context, state) {
            if (state is EventOrganizerLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is EventOrganizerFailure) {
              return const EventOrganizerRequestPage();
            }
            if (state is EventOrganizerSuccess) {
              // Check the status of the event organizer
              if (state.eventOrganizer.status == EventOrganizerStatus.PENDING ||
                  state.eventOrganizer.status ==
                      EventOrganizerStatus.INACTIVE) {
                return const RequestEoPendingScreen();
              } else if (state.eventOrganizer.status ==
                  EventOrganizerStatus.ACTIVE) {
                return EventOrganizerDashboardScreen(); // Replace with your actual dashboard screen
              }
            }
            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
