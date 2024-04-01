class EventAttendees {
  final String eventTitle;
  final List<EventAttendee> attendees;
  EventAttendees(this.eventTitle, this.attendees);
}

class EventAttendee {
  final String name, userRole, userImageUrl;
  const EventAttendee(
      this.name, this.userRole, this.userImageUrl);
}
