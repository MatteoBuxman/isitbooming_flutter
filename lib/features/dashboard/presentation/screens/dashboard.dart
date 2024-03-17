// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sandbox/features/dashboard/data/models/boom_thumbnail.dart';
import 'package:sandbox/features/dashboard/data/repositories/my_booms_repository.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/boom_thumbnail.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashboardRepository = MyBoomsRepository();
  final List<BoomThumbnail> gridContents = [];

  @override
  void initState() {
    //Fetch and assign grid contents
    dashboardRepository.getBoomThumbnails().then((value) {
      setState(() {
        gridContents.addAll(value);
      });
    });

    super.initState();
  }

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
              gridContents.isNotEmpty
                  ? Expanded(
                      child: TabBarView(children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 9 / 16,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                        ),
                        itemCount: gridContents.length,
                        itemBuilder: (context, index) {
                          BoomThumbnail boomThumbnail = gridContents[index];
                          return BoomThumbnailWidget(boomThumbnail);
                        },
                      ),
                      Center(child: Text('Events')),
                      Center(child: Text('Locations'))
                    ]))
                  : Container(
                      color: Colors.blue,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
