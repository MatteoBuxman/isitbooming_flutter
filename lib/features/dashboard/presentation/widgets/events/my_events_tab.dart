import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sandbox/features/dashboard/business_logic/event_list_cubit.dart';
import 'package:sandbox/features/dashboard/business_logic/states/event_list_state.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/events/widgets/current_event_unit.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/events/widgets/past_event_unit.dart';

class MyEventsTab extends StatefulWidget {
  const MyEventsTab({super.key});

  @override
  State<MyEventsTab> createState() => _MyEventsTabState();
}

class _MyEventsTabState extends State<MyEventsTab> {
  void _openCreateNewEventSheet() {
    bool isPrivate = true;
    bool isTickets = false;

    showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create New Event',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Title...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '9:41 PM 19/01/2024',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '11:41 PM 19/01/2024',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Description...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 4,
                  style: const TextStyle(color: Colors.black, fontSize: 13.0),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This is a private event.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'If set to public, this event will appear publicly on the BoomScape, or when a user searches for it on the explore page.',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isPrivate,
                      onChanged: (value) {
                        setState(() {
                          isPrivate = value;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This is a ticketed event.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'You can manage ticketing through IsItBooming.',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: isTickets,
                      onChanged: (value) {
                        setState(() {
                          isTickets = value;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Select location'),
                        ),
                      );
                    }));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<EventListCubit, EventListState>(
        builder: (context, state) {
          //Length of the event list (has to account for the section headings)

          if (state is LoadedEventListState) {
            final currentEventListLength = state.currentEvents.length;
            final pastEventListLength = state.currentEvents.length;

            final eventListLength = currentEventListLength +
                pastEventListLength +
                (state.pastEvents.isEmpty ? 1 : 3);

            return Column(
              children: [
                TextButton(
                    onPressed: _openCreateNewEventSheet,
                    child: const Text(
                      "Create new event",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: ListView.separated(
                    itemCount: eventListLength,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Current Events",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      } else if (index <= currentEventListLength) {
                        return CurrentEventUnit(
                            event: state.currentEvents[index - 1]);
                      } else if (index == currentEventListLength + 1) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Past Events",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      } else {
                        return PastEventUnit(
                            event: state.pastEvents[
                                index - (currentEventListLength + 2)]);
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (state is LoadingEventListState) {
            return const Text("Loading your events");
          } else if (state is ErrorEventListState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.error.error),
                Text(
                    'Error code: ${state.error.errorCode ?? '1'}')
              ],
            );
          }
          //This statement should never be run as all the accepted states have been accounted for
          else {
            return const Text("An unknown event list state was returned");
          }
        },
      ),
    );
  }
}
