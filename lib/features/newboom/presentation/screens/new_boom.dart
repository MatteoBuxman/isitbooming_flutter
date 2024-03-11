import 'package:flutter/material.dart';

class NewBoom extends StatefulWidget {
  const NewBoom({super.key});

  @override
  State<NewBoom> createState() => _NewBoomState();
}

class _NewBoomState extends State<NewBoom> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Add a new boom or event you are going to.'),
    );
  }
}