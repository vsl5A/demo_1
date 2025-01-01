import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../cubit/cubit_couter.dart';



class AccUser extends StatelessWidget {
  AccUser({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController confirmPasswordSignUpController = TextEditingController();
  TextEditingController firstNameSignUpController = TextEditingController();
  TextEditingController lastNameSignUpController = TextEditingController();

  Widget buildLogin(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, Map<String, dynamic>>(
        builder: (context, state) => SingleChildScrollView(
          child: Center(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            //color: Colors.blue,
                            padding: const EdgeInsets.all(16.0),
                            child: const Center(
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: FormField(
                        builder: (FormFieldState<String> state) {
                          return TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: usernameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "username",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: FormField(
                        builder: (FormFieldState<String> state) {
                          return TextFormField(
                            controller: passwordController,
                            obscureText: context.read<CartCubit>().state['passwordVisible'],
                            textInputAction: TextInputAction.done,
                            decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () => context.read<CartCubit>().setPasswordVisible(),
                                icon: Icon(
                                  context.read<CartCubit>().state['passwordVisible']
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            // Your login logic here
                            final body = {
                              "username": usernameController.text,
                              "password": passwordController.text
                            };
                            final url = Uri.parse('${Constants.baseUrl}/users/login');
                            final res = await http.post(
                              url,
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(body),
                            );
                            if (res.statusCode == 200) {
                              context.read<CartCubit>().setToken(res.body);
                              context.read<CartCubit>().setIndexWidget(0);
                              context.read<CartCubit>().startTokenExpiration();

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Incorrect username or password')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill input')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Login', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('OR'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No account yet?'),
                        TextButton(
                          onPressed: () {
                            context.read<CartCubit>().setIsLogin(false);
                          },
                          child: const Text('SignUp'),
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

  Widget buildSignUp(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, Map<String, dynamic>>(
        builder: (context, state) => SingleChildScrollView(
          child: Center(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            //color: Colors.blue,
                            padding: const EdgeInsets.all(16.0),
                            child: const Center(
                              child: Text(
                                'CREATE A NEW ACCOUNT',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row (
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: firstNameSignUpController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "First Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your First Name';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: lastNameSignUpController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Last Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Last Name';
                                  }
                                  return null;
                                },
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: FormField(
                        builder: (FormFieldState<String> state) {
                          return TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: usernameSignUpController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "username",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: FormField(
                        builder: (FormFieldState<String> state) {
                          return TextFormField(
                            controller: passwordSignUpController,
                            obscureText:context.read<CartCubit>().state['passwordVisible'],
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () => context.read<CartCubit>().setPasswordVisible(),
                                  icon: Icon(
                                    context.read<CartCubit>().state['passwordVisible']
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                )
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: FormField(
                        builder: (FormFieldState<String> state) {
                          return TextFormField(
                            controller: confirmPasswordSignUpController,
                            obscureText:context.read<CartCubit>().state['passwordComfrimVisible'],
                            textInputAction: TextInputAction.done,
                            decoration:   InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Confirm Password",
                                suffixIcon: IconButton(
                                  onPressed: () => context.read<CartCubit>().setPasswordComfrimVisible(),
                                  icon: Icon(
                                    context.read<CartCubit>().state['passwordComfrimVisible']
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if(passwordSignUpController.text == confirmPasswordSignUpController.text) {
                            if (usernameSignUpController.text.isNotEmpty &&
                                passwordSignUpController.text.isNotEmpty&&
                                lastNameSignUpController.text.isNotEmpty&&
                                firstNameSignUpController.text.isNotEmpty) {

                              final url = Uri.parse('${Constants.baseUrl}/users/register');
                              // Thay thế bằng URL thực tế
                              final body = {
                                "name": '${lastNameSignUpController.text} ${firstNameSignUpController.text}',
                                "username": usernameSignUpController.text,
                                "password": passwordSignUpController.text
                              };
                              final res = await http.post(
                                  url,
                                  headers: <String, String>{
                                    'Content-Type': 'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(body) );
                              //final List<dynamic> data = jsonDecode(res.body);
                              if (res.statusCode == 400) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Username already exists')),
                                );
                              } else if (res.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('CREATE A NEW ACCOUNT SUCCESS')),
                                );
                                Future.delayed(const Duration(seconds: 5), () {

                                });
                              }
                              // print('check res user ${data[1]['password']}');

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill input')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match. Please try again.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextButton(
                          onPressed: () {
                            context.read<CartCubit>().setIsLogin(true);
                          },
                          child: const Text('Already have an account?'),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Map<String, dynamic>>(
      builder: (context, state) {
        bool isLogin = state['isLogin'] ?? false;
        if (isLogin) {
          return buildLogin(context);
        } else {
          return buildSignUp(context);
        }
      },
    );
  }}
