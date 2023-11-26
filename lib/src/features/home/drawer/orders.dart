import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: const Color(0xff1a1a1a),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Orders",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 200),
            Align(
              alignment: Alignment.center,
              child: Text(
                "You don't have any orders yet",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 330),
            Align(alignment: Alignment.bottomCenter,
              child: Card(
                color: Colors.amber,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                      child: Text(
                    "Select restaurant",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}