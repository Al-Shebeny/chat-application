part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Massege> masseges;

  ChatSuccess({required this.masseges});
}
