import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/dashboard/business_logic/dashboard_boom_grid_cubit.dart';
import 'package:sandbox/features/dashboard/business_logic/states/dashboard_grid_state.dart';
import 'package:sandbox/features/dashboard/presentation/widgets/booms/widgets/boom_thumbnail.dart';

class MyBoomsTab extends StatefulWidget {
  const MyBoomsTab({super.key});

  @override
  State<MyBoomsTab> createState() => _MyBoomsTabState();
}

class _MyBoomsTabState extends State<MyBoomsTab> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBoomGridCubit, DashboardGridState>(
        builder: (context, state) {
      if (state is LoadedDashboardGridState) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 9 / 16,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemCount: state.boomGrid.length,
          itemBuilder: (context, index) {
            return BoomThumbnailWidget(state.boomGrid[index]);
          },
        );
      } else if (state is LoadingDashboardGridState) {
        return const Text("Loading your booms");
      } else if (state is ErrorDashboardGridState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.error.error),
            Text('Error code: ${state.error.errorCode ?? 'No error code supplied.'}')
          ],
        );
      } else {
        //This should never run
        return const Text("An unknown error occured");
      }
    });
  }
}
