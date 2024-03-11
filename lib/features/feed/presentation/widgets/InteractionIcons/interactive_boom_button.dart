import 'package:flutter/material.dart';

class InteractiveBoomButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool initialCondition;

  const InteractiveBoomButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.initialCondition});

  @override
  State<InteractiveBoomButton> createState() => _InteractiveBoomButtonState();
}

class _InteractiveBoomButtonState extends State<InteractiveBoomButton> {
  final int _durationTime = 200;
  final double _animationScaleFactor = 1.1;
  late bool isClicked;

  @override
  void initState() {
    isClicked = widget.initialCondition;
    super.initState();
  }

  double _scale = 1.0;

  void handleClick() {
    //Handle the animation when a user clicks on one of the Boom interaction buttons(grow and shrink)
    setState(() {
      isClicked = !isClicked;
      _scale = _animationScaleFactor;
    });

    Future.delayed(Duration(milliseconds: _durationTime), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => handleClick(),
        child: Column(
          children: [
            AnimatedScale(
                scale: _scale,
                duration: Duration(milliseconds: _durationTime),
                curve: Curves.easeOut,
                child: Icon(widget.icon,
                    color: isClicked ? Colors.amber.shade600 : null)),
            Text(widget.label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ],
        ));
  }
}
