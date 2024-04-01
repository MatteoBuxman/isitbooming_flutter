import 'package:flutter/material.dart';

class PastEventUnit extends StatefulWidget {
  const PastEventUnit({super.key});

  @override
  State<PastEventUnit> createState() => _PastEventUnitState();
}

class _PastEventUnitState extends State<PastEventUnit> {
  void _handleWhoIsThere() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Who was there'),
        ),
      );
    }));
  }

  void _handleChat() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('See Booms'),
        ),
      );
    }));
  }

  //Handle a click on the actual event card
  void _handleEventClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Event breakdown'),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color.fromRGBO(202, 202, 202, 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: _handleEventClick,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'John\'s Predrinks',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7, right: 7),
                          child: Text(
                            'Kong Afterwards',
                            style: TextStyle(fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '7:30PM to 10:30PM',
                      style: TextStyle(fontSize: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Hi guys, I\'m having a predrinks for my 19th birthday. I\'ll see you all there!',
                          style: TextStyle(fontSize: 10),
                          
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: _handleWhoIsThere,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.people_alt_sharp,
                            color: Colors.blue.shade400,
                            size: 20,
                          ),
                          const Text("Who was there?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                              softWrap: true)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: _handleChat,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.blue.shade400,
                              size: 20,
                            ),
                            const Text("See Booms",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                                softWrap: true)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
