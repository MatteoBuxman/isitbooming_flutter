import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/core/feed/feed_controller.dart';
import 'package:sandbox/core/tab_bar/business_logic/tab_cubit.dart';
import 'package:sandbox/features/dashboard/presentation/screens/dashboard.dart';
import 'package:sandbox/features/feed/business_logic/boom_feed_cubit.dart';
import 'package:sandbox/features/feed/presentation/screens/feed.dart';
import 'package:sandbox/features/boomscape/presentation/screens/boomscape.dart';
import 'package:sandbox/features/newboom/presentation/screens/new_boom.dart';
import 'package:sandbox/features/explore/presentation/screens/explore.dart';

class BoomNavigationBar extends StatelessWidget {

  //Instantiate BLOCS here so they persist when a user switches away from the screen they are used on.
  //This seems more efficient for cases like the BoomFeedCubit which shouldn't need to reload all controller
  //just because a user switched away from the screen.
  final _boomFeedCubit = BoomFeedCubit();

  BoomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, SelectedTab>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(
                color: state == SelectedTab.feed ? Colors.white : Colors.black,
                fontSize: 12);
          })),
          child: NavigationBar(
            indicatorColor: const Color.fromRGBO(99, 32, 238, 1.0),
            height: 64,
            elevation: 5.0,
            selectedIndex: state.index,
            destinations: [
              NavigationDestination(
                  icon: Icon(
                    Icons.feed_outlined,
                    color:
                        state == SelectedTab.feed ? Colors.white : Colors.black,
                  ),
                  selectedIcon: const Icon(
                    Icons.feed_rounded,
                    color: Colors.white,
                  ),
                  label: 'Feed'),
              NavigationDestination(
                icon: Icon(
                  Icons.map_outlined,
                  color: state == SelectedTab.boomscape ||
                          state == SelectedTab.feed
                      ? Colors.white
                      : Colors.black,
                ),
                selectedIcon: const Icon(
                  Icons.map_sharp,
                  color: Colors.white,
                ),
                label: 'BoomScape',
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: state == SelectedTab.newBoom ||
                            state == SelectedTab.feed
                        ? Colors.white
                        : Colors.black,
                  ),
                  selectedIcon: const Icon(
                    Icons.add_box,
                    color: Colors.white,
                  ),
                  label: 'New'),
              NavigationDestination(
                  icon: Icon(
                    Icons.explore_outlined,
                    color: state == SelectedTab.explore ||
                            state == SelectedTab.feed
                        ? Colors.white
                        : Colors.black,
                  ),
                  selectedIcon: const Icon(Icons.explore, color: Colors.white),
                  label: 'Explore'),
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined,
                    color: state == SelectedTab.dashboard ||
                            state == SelectedTab.feed
                        ? Colors.white
                        : Colors.black),
                selectedIcon: const Icon(Icons.dashboard, color: Colors.white),
                label: 'Dashboard',
              ),
            ],
            onDestinationSelected: (value) {
              context.read<TabCubit>().setTab(value);
            },
            backgroundColor: context.read<TabCubit>().state == SelectedTab.feed
                ? Colors.black
                : Colors.white,
            surfaceTintColor:
                state == SelectedTab.feed ? Colors.black : Colors.white,
          ),
        ),
        body: [
          //Using value to persist the BLOC when the user goes to a different tab. It seems wasteful to reinitialize all the video players.
          BlocProvider<FeedController>.value(value: _boomFeedCubit, child: const Feed(),),
          const Boomscape(),
          const NewBoom(),
          const Explore(),
          const Dashboard(),
        ][state.index],
      ),
    );
  }
}
