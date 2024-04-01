import 'package:sandbox/features/dashboard/data/errors/boom_list_fetch_exception.dart';
import 'package:sandbox/features/feed/data/models/boom.dart';

class DashboardGridState {}

class LoadingDashboardGridState extends DashboardGridState {}

class LoadedDashboardGridState extends DashboardGridState {
  List<Boom> boomGrid;
  LoadedDashboardGridState(this.boomGrid);
}

class ErrorDashboardGridState extends DashboardGridState {
  BoomListFetchException error;
  ErrorDashboardGridState(this.error);
}
