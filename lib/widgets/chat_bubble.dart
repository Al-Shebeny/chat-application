import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/massege.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.massege,
  });
  final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Text(
          massege.massege,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleForFrinde extends StatelessWidget {
  const ChatBubbleForFrinde({
    super.key,
    required this.massege,
  });
  final Massege massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
            color: Color(0xff006d84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Text(
          massege.massege,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
