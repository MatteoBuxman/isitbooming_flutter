import 'package:flutter/material.dart';

class Boomscape extends StatefulWidget {
  const Boomscape({super.key});

  @override
  State<Boomscape> createState() => _BoomscapeState();
}

class _BoomscapeState extends State<Boomscape> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('BoomScape'),
    );
  }
}