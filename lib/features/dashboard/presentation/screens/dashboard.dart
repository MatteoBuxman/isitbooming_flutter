// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/my_booms_tab.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/my_events_tab.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/my_location_tab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Center(
        child: SafeArea(
          child: Column(
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  children: [
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
                  children: [
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
              TabBar(tabs: [
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
                MyBoomsTab(),
                MyEventsTab(),
                MyLocationsTab()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
