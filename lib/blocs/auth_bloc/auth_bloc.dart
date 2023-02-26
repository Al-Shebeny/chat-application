import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late String email;

  late String password;
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoding());
        try {
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          debugPrint("the bloc @@@ $user ");
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'wrong-password') {
            emit(LoginFaliur(
                errMasage: 'Wrong password provided for that user.'));
          } else if (ex.code == 'user-not-found') {
            emit(LoginFaliur(errMasage: 'No user found for that email.'));
          }
        } catch (ex) {
          emit(LoginFaliur(errMasage: 'something went wronge'));
        }
      }
      if (event is RegisterEvent) {
        emit(RegisterLoding());
        try {
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.createUserWithEmailAndPassword(
              email: email, password: password);
          debugPrint("the bloc @@@ $user ");
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFaliur(
                errMasage: 'The password provided is too weak.'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFaliur(
                errMasage: 'The account already exists for that email.'));
          }
        } catch (ex) {
          emit(
              RegisterFaliur(errMasage: 'there was an errer please try again'));
        }
      }
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    debugPrint("the bloc @@@ $transition ");
  }
}
