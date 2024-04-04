import 'package:flutter/material.dart';
import 'package:sandbox/features/dashboard/data/models/event.dart';
import 'package:sandbox/features/dashboard/data/models/event_attendees.dart';
import 'package:sandbox/features/dashboard/presentation/screens/event_attendees_list.dart';

final mockEventAttendees = EventAttendees(
  'John\'s Pre-drinks',
  [
    const EventAttendee(
      'John Doe',
      'Speaker',
      'https://example.com/john-doe.jpg',
    ),
    const EventAttendee(
      'Jane Smith',
      'Organizer',
      'https://example.com/jane-smith.jpg',
    ),
    const EventAttendee(
      'Mark Johnson',
      'Attendee',
      'https://example.com/mark-johnson.jpg',
    ),
    const EventAttendee(
      'Emily Davis',
      'Sponsor',
      'https://example.com/emily-davis.jpg',
    ),
    const EventAttendee(
      'Michael Brown',
      'Volunteer',
      'https://example.com/michael-brown.jpg',
    ),
  ],
);

class CurrentEventUnit extends StatefulWidget {
  final Event event;
  const CurrentEventUnit({super.key, required this.event});

  @override
  State<CurrentEventUnit> createState() => _CurrentEventUnitState();
}

class _CurrentEventUnitState extends State<CurrentEventUnit> {
  void _handleWhoIsThere() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAttendeesList(mockEventAttendees)));
  }

  void _handleChat() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Chat'),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color.fromRGBO(202, 202, 202, 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.event.eventName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 7, right: 7),
                      //   child: Text(
                      //     'Kong Afterwards',
                      //     style: TextStyle(fontSize: 11),
                      //   ),
                      // )
                    ],
                  ),
                  Text(
                    widget.event.startTime.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.event.eventDescription,
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: _handleWhoIsThere,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.people_alt_sharp,
                            color: Colors.blue.shade400,
                            size: 20,
                          ),
                          const Text("Who's coming?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                              softWrap: true)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: _handleChat,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.chat,
                              color: Colors.blue.shade400,
                              size: 20,
                            ),
                            const Text("Chat",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                                softWrap: true)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
