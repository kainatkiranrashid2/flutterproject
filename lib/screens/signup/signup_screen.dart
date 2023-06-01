import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/cubits/signup/signup_cubit.dart';

import '../../widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Signup'),
        bottomNavigationBar: const CustomNavbar(
          screen: routeName,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _UserInput(
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(email: value));
                          },
                          labelText: 'Email'),
                      const SizedBox(height: 10),
                      _UserInput(
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(fullName: value));
                          },
                          labelText: 'FullName'),
                      const SizedBox(height: 10),
                      _UserInput(
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(country: value));
                          },
                          labelText: 'Country'),
                      const SizedBox(height: 10),
                      _UserInput(
                          onChanged: (value) {
                            context
                                .read<SignupCubit>()
                                .userChanged(state.user!.copyWith(city: value));
                          },
                          labelText: 'City'),
                      const SizedBox(height: 10),
                      _UserInput(
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(address: value));
                          },
                          labelText: 'Address'),
                      const SizedBox(height: 10),
                      _UserInput(
                          onChanged: (value) {
                            context.read<SignupCubit>().userChanged(
                                state.user!.copyWith(zipCode: value));
                          },
                          labelText: 'ZipCode'),
                      const SizedBox(height: 10),
                      const _PasswordInput(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SignupCubit>().signupWithCredentials();
                          Navigator.pushNamed(context, '/profile');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                            fixedSize: const Size(200, 40)),
                        child: Text(
                          'Sign up',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ]),
              );
            },
          ),
        ));
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    required this.onChanged,
    required this.labelText,
    super.key,
  });
  final Function(String)? onChanged;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
