import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sandbox/core/feed/feed_controller.dart';
import 'package:sandbox/features/feed/business_logic/states/feed_state.dart';
import 'package:sandbox/features/feed/presentation/widgets/feed_item.dart';
import 'package:sandbox/features/feed/presentation/widgets/isitbooming_heading.dart';

class FeedScroll extends StatefulWidget {
  final FeedController _feedCubit;
  const FeedScroll({super.key, required FeedController controllingCubit}) : 
    _feedCubit = controllingCubit;

  @override
  State<FeedScroll> createState() => _FeedScrollState();
}

class _FeedScrollState extends State<FeedScroll> {

  final loader = const SpinKitFoldingCube(
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedController, FeedState>(
      builder: (context, data) => Stack(
        children: [
          data is LoadedFeedState
              ? PageView.builder(
                  controller: PageController(
                      initialPage: data.initialBoomIndex),
                  itemCount: data.feed.length,
                  onPageChanged: (newIndex) =>
                      widget._feedCubit.reportScroll(newIndex),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => FeedItem(data.feed[index]),
                )
              : Container(
                  color: Colors.black,
                  child: Center(
                    child: loader,
                  ),
                ),
          const IsItBoomingHeading(),
        ],
      ),
    );
  }
}
