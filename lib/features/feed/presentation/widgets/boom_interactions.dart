import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';
import 'package:sandbox/features/feed/presentation/screens/venue_dashboard_page.dart';
import 'package:sandbox/features/feed/business_logic/boom_feed_cubit.dart';
import '../screens/foreign_user_dashboard.dart';
import 'package:sandbox/features/feed/presentation/widgets/InteractionIcons/interactive_boom_button.dart';

class BoomInteractions extends StatefulWidget {
  final Boom boomModel;
  const BoomInteractions({super.key, required this.boomModel});

  @override
  State<BoomInteractions> createState() => _BoomInteractionsState();
}

class _BoomInteractionsState extends State<BoomInteractions> {
  //Get a reference to the current BoomFeedBloc, to be able to pause the current boom when navigating to another route.
  late BoomFeedCubit _boomFeedCubit;

  @override
  void initState() {
    _boomFeedCubit = BlocProvider.of<BoomFeedCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(size: 32, color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //The user who posted the Boom.
              Container(
                  padding: const EdgeInsets.only(bottom: 15, left: 15),
                  child: Row(
                    children: [
                      Text(
                        widget.boomModel.username,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        ' @ ${widget.boomModel.location.name}',
                        style: const TextStyle(                         
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 0),
                child: SizedBox(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _boomFeedCubit.pauseCurrentPlayer();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForeignUserDashboard()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 10,
                                        )
                                      ]),
                                  child: const Icon(Icons.account_circle,
                                      size: 38))),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _boomFeedCubit.pauseCurrentPlayer();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VenueDashboardPage()));
                              },
                              child: const Icon(Icons.pin_drop, size: 38)),
                        ],
                      ),
                      InteractiveBoomButton(
                          icon: Icons.save,
                          label: 'Save',
                          initialCondition: widget.boomModel.isSaved),
                      InteractiveBoomButton(
                          icon: Icons.sentiment_satisfied_alt,
                          label: 'Hype',
                          initialCondition: widget.boomModel.isHyped),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
