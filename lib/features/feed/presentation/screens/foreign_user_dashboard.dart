import 'package:flutter/material.dart';

class ForeignUserDashboard extends StatelessWidget {
  const ForeignUserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The foreign user dashboard'),
            ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Go back'))
          ],
        ),
      ),
    );
  }
}
