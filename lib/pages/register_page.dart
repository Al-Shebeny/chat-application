import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../constants.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custom_snackBar.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = 'registerPage';

  static GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoding) {
            // isLoding = true;
          } else if (state is RegisterSuccess) {
            // isLoding = false;
            BlocProvider.of<ChatCubit>(context).getMassege();
            Navigator.pushNamed(context, ChatPage.id);
          } else if (state is RegisterFaliur) {
            // isLoding = false;
            showSnackBar(context, state.errMasage);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is RegisterLoding ? true : false,
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
                            'Register',
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
                        hintText: 'Password',
                        onChange: (data) {
                          BlocProvider.of<AuthBloc>(context).password = data;
                        },
                      ),
                      const SizedBox(height: 25),
                      CustomBotton(
                          tittle: 'Register',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(RegisterEvent());
                            } else {}
                          }),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account ? ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
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
          );
        },
      ),
    );
  }
}
