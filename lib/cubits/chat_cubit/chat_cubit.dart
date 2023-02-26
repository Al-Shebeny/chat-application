import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/massege.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Massege> massegesList = [];

  CollectionReference masseges =
      FirebaseFirestore.instance.collection(kMassegeCollection);

  void sendMassege({required String massege, required String email}) {
    masseges.add({kMassege: massege, kCreatedAt: DateTime.now(), 'id': email});
  }

  void getMassege() {
    masseges.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      massegesList.clear();
      for (var doc in event.docs) {
        massegesList.add(Massege.fromJson(doc));
      }
      emit(ChatSuccess(masseges: massegesList));
    });
  }
}
