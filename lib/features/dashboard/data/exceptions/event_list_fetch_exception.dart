//Thrown when there is a error with fetching a group of booms. For instance, on the user dashboard, or when clicking on 'see booms' on an event.

class EventListFetchException implements Exception {
  final String error;
  final int? errorCode;
  EventListFetchException(this.error, {this.errorCode});
}
