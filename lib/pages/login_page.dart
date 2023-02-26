import 'package:flutter/material.dart';
import 'package:flutter_application_1788/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_application_1788/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String id = 'loginPage';

  static final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            BlocProvider.of<ChatCubit>(context).getMassege();

            Navigator.pushNamed(context, ChatPage.id);
          } else if (state is LoginFaliur) {
            showSnackBar(context, state.errMasage);
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: state is LoginLoding ? true : false,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      kLogo,
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Shcolar Chat',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: const [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Email',
                      onChange: (data) {
                        BlocProvider.of<AuthBloc>(context).email = data;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      obscureText: true,
                      hintText: 'Password',
                      onChange: (data) {
                        BlocProvider.of<AuthBloc>(context).password = data;
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomBotton(
                      tittle: 'Sign In',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent());
                        } else {}
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xffc7ede6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
