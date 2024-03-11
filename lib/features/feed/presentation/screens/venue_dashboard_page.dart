import 'package:flutter/material.dart';

class VenueDashboardPage extends StatelessWidget {
  const VenueDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The Venue Page'),
            ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Go back'))
          ],
        ),
      ),
    );
  }
}