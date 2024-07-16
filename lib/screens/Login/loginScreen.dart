import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/local/cache_helper.dart';
import 'package:shop_app/screens/Login/cubit/logic.dart';
import 'package:shop_app/screens/Login/cubit/states.dart';
import 'package:shop_app/screens/rigister/registerScreen.dart';
import 'package:shop_app/styles/color.dart';
import 'package:shop_app/widget/textFormFieldWidget.dart';

import '../shopHomeScreen/shop_home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data.token)
                  .then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShopHomeScreen()));
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Login ",
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          " Login now to browser our hot offer  ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Email Must Not Be Empty ';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            label: const Text(
                              " Login",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Is To Short';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          // onSubmitted: (value)
                          // {
                          //   if(formKey.currentState!.validate())
                          //   {
                          //     ShopCubit.get(context).userPostLoginData(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // },
                          label: const Text(
                            " Password",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          isPassword: ShopLoginCubit.get(context).visibility,
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                ShopLoginCubit.get(context)
                                    .changeVisibilityOfPassword();
                              },
                              icon: ShopLoginCubit.get(context).visibility
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye_outlined,
                                    )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Conditional.single(
                                context: context,
                                conditionBuilder: (context) =>
                                    state is! ShopLoginLoadingState,
                                widgetBuilder: (context) => MaterialButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          ShopLoginCubit.get(context)
                                              .userPostLoginData(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      color: mainColor,
                                      child: const Text(
                                        "LOGIN",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                fallbackBuilder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ))),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("I do\'t have an account "),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()));
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                    color: mainColor,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
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
