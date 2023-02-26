import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../constants.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'chat page';

  static TextEditingController controller = TextEditingController();
  static final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var massegesList =
                    BlocProvider.of<ChatCubit>(context).massegesList;

                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: massegesList.length,
                    itemBuilder: (context, index) {
                      return massegesList[index].id ==
                              BlocProvider.of<AuthBloc>(context).email
                          ? ChatBubble(massege: massegesList[index])
                          : ChatBubbleForFrinde(massege: massegesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMassege(
                    massege: data,
                    email: BlocProvider.of<AuthBloc>(context).email);
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
                      borderSide: const BorderSide(color: kPrimaryColor))),
            ),
          )
        ],
      ),
    ));
  }

  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
