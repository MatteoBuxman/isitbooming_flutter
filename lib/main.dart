import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/core/tab_bar/business_logic/tab_cubit.dart';
import 'package:sandbox/core/tab_bar/presentation/boom_navigation_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabCubit>(
      create: (_) => TabCubit(),
      child: MaterialApp(
        title: 'IsItBooming',
        home: Theme(data: ThemeData(), child: BoomNavigationBar()),
      ),
    );
  }
}
