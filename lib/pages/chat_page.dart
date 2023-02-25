import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/massege.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'chat page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();

  CollectionReference masseges =
      FirebaseFirestore.instance.collection(kMassegeCollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: masseges.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Massege> massegesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massegesList.add(Massege.fromJson(snapshot.data!.docs[i]));
            }

            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text('Chat')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: massegesList.length,
                        itemBuilder: (context, index) {
                          return massegesList[index].id == email
                              ? ChatBubble(massege: massegesList[index])
                              : ChatBubbleForFrinde(
                                  massege: massegesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        masseges.add({
                          kMassege: data,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _scrollDown();
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.send),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor))),
                    ),
                  )
                ],
              ),
            ));
          } else {
            return const SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.blue,
                    body: Center(
                        child: Text(
                      'loding....',
                      style: TextStyle(fontSize: 25, color: Colors.pinkAccent),
                    ))));
          }
        });
  }

  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
