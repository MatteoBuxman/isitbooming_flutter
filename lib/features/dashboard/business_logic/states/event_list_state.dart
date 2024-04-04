import 'package:sandbox/features/dashboard/data/exceptions/event_list_fetch_exception.dart';
import 'package:sandbox/features/dashboard/data/models/event.dart';

class EventListState {}

class LoadingEventListState extends EventListState {}

class LoadedEventListState extends EventListState {
  List<Event> currentEvents;
  List<Event> pastEvents;

  LoadedEventListState({required this.currentEvents, required this.pastEvents});
}

class ErrorEventListState extends EventListState {
  EventListFetchException error;
  ErrorEventListState(this.error);
}
