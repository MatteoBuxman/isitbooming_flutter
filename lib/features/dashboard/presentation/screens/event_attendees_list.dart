import 'package:flutter/material.dart';
import 'package:sandbox/features/dashboard/data/models/event_attendees.dart';

class EventAttendeesList extends StatefulWidget {
  final EventAttendees attendees;

  const EventAttendeesList(this.attendees, {super.key});

  @override
  State<EventAttendeesList> createState() => _EventAttendeesListState();
}

class _EventAttendeesListState extends State<EventAttendeesList> {
  final eventAttendeesList = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.attendees.eventTitle),
      ),
      body: ListView(
        children: List.generate(3, (index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.attendees.attendees[index].userImageUrl),
            ),
            title: Text(
              widget.attendees.attendees[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              widget.attendees.attendees[index].userRole,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
              ),
            ),
            trailing: Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
          );
        }),
      ),
    );
  }
}
