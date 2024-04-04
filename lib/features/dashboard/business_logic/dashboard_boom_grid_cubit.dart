import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/features/dashboard/business_logic/states/dashboard_grid_state.dart';
import 'package:sandbox/features/dashboard/data/exceptions/boom_list_fetch_exception.dart';
import 'package:sandbox/features/dashboard/data/repositories/my_booms_repository.dart';

class DashboardBoomGridCubit extends Cubit<DashboardGridState> {
  final dashboardRepository = MyBoomsRepository();

  DashboardBoomGridCubit() : super(LoadingDashboardGridState()) {
    initBloc();
  }

  //Method to initialize the bloc and fetch the user's dashboard items
  void initBloc() async {
    try {
      final userDashboard = await dashboardRepository.getUserDashboard();
      emit(LoadedDashboardGridState(userDashboard));
    } on BoomListFetchException catch (e) {
      emit(ErrorDashboardGridState(e));
    } catch (e) {
      emit(ErrorDashboardGridState(BoomListFetchException(
          'We encountered an unknown error: ${e.toString()}')));
    }
  }
}
