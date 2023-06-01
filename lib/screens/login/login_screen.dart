import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/cubits/login/login_cubit.dart';
import 'package:semesterproject/widgets/custom_appbar.dart';

import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Login'),
        bottomNavigationBar: const CustomNavbar(
          screen: routeName,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _EmailInput(),
            const SizedBox(
              height: 10,
            ),
            _PasswordInput(),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginCubit>().loginWithCredentials();
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(),
                  fixedSize: const Size(200, 40)),
              child: Text(
                'Login',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _GoogleLoginButton(),
          ]),
        ));
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<LoginCubit>().emailChanged(value);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LoginCubit>().loginWithGoogle();
      },
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          backgroundColor: Colors.white,
          fixedSize: const Size(200, 40)),
      child: Text(
        'Sign in with Google',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.blue),
      ),
    );
  }
}
