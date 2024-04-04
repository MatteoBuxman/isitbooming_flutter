import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/dashboard/business_logic/states/event_list_state.dart';
import 'package:sandbox/features/dashboard/data/exceptions/event_list_fetch_exception.dart';
import 'package:sandbox/features/dashboard/data/repositories/my_events_repository.dart';

class EventListCubit extends Cubit<EventListState> {
  final eventsRepository = MyEventsRepository();

  EventListCubit() : super(LoadingEventListState()) {
    initList();
  }

  //Initialize the user list
  void initList() async {
    try {
      final userEvents = await eventsRepository.getUserEvents();

      final currentEvents = userEvents['currentEvents'];
      final pastEvents = userEvents['pastEvents'];

      if (currentEvents == null || pastEvents == null) {
        emit(ErrorEventListState(EventListFetchException(
            "The event list fetch returned null",
            errorCode: 1)));
        return;
      }

      emit(LoadedEventListState(
          currentEvents: currentEvents, pastEvents: pastEvents));
    } on EventListFetchException catch (e) {
      emit(ErrorEventListState(e));
    }
  }
}
