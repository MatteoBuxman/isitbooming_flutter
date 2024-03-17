import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectedTab {
  feed,
  boomscape,
  newBoom,
  explore,
  dashboard;
}

class TabCubit extends Cubit<SelectedTab> {
  //Set the initial state of the app to be the feed page
  TabCubit() : super(SelectedTab.dashboard);

  void setTab(int newTabIndex) {
    switch (newTabIndex) {
      case 0:
        emit(SelectedTab.feed);
      case 1:
        emit(SelectedTab.boomscape);
      case 2:
        emit(SelectedTab.newBoom);
      case 3:
        emit(SelectedTab.explore);
      case 4:
        emit(SelectedTab.dashboard);
    }
    ;
  }
}
