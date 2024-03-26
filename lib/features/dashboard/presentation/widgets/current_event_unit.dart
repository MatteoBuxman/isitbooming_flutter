import 'package:flutter/material.dart';

class CurrentEventUnit extends StatefulWidget {
  const CurrentEventUnit({super.key});

  @override
  State<CurrentEventUnit> createState() => _CurrentEventUnitState();
}

class _CurrentEventUnitState extends State<CurrentEventUnit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color.fromRGBO(202, 202, 202, 1.0),),
          ),
      child: const Padding(
        padding:  EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('John\'s Predrinks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                    Padding(
                      padding: EdgeInsets.only(left: 7, right: 7),
                      child: Text('Kong Afterwards', style: TextStyle(fontSize: 11),),
                    )
                  ],
                ),
                Text('7:30PM to 10:30PM', style: TextStyle(fontSize: 10),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold) ,),
                    Text('Hi guys, I\'m having a predrinks for my 19th birthday.\n I\'ll see you all there!', style: TextStyle(fontSize: 10), overflow: TextOverflow.ellipsis,)
                  ],
                )
              ],
            ),
            Column(
              children: [
        
              ],
            )
          ],
        ),
      ),
    );
  }
}
