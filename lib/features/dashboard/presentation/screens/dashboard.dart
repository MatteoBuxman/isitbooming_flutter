// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/dashboard/business_logic/dashboard_boom_grid_cubit.dart';
import 'package:sandbox/features/dashboard/business_logic/event_list_cubit.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/booms/my_booms_tab.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/events/my_events_tab.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/locations/my_location_tab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //The cubit for the user's boom grid
  final _userBoomCubit = DashboardBoomGridCubit();
  final _userEventCubit = EventListCubit();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Center(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 10),
                    child: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.face,
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Matteo Buxman',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Row(
                            children: [
                              Text(
                                'Member of ',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Bad Boyz 4 Life',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 13,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "Add Bio",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      children: [
                        Text(
                          '84',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '126',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '56',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          'Booms',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              TabBar(tabs: const [
                Tab(
                  text: 'My Booms',
                ),
                Tab(
                  text: 'My Events',
                ),
                Tab(
                  text: 'My Locations',
                )
              ]),
              Expanded(
                  child: TabBarView(children: [
                //I use .value because the default BlocProvider destroys itself whenever all listeners are destroyed, this is an issue in the tab system where the Booms Tab component lives. I rather choose to only destroy it when the user navigates away from the dashboard page.
                BlocProvider.value(value: _userBoomCubit, child: MyBoomsTab()),
                BlocProvider.value(value: _userEventCubit, child: MyEventsTab(),),
                MyLocationsTab()
              ]))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userBoomCubit.close();
    _userEventCubit.close();
    super.dispose();
  }
}
