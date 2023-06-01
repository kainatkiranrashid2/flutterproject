import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/blocs/auth/auth_bloc.dart';
import 'package:semesterproject/blocs/profile/profile_bloc.dart';
import 'package:semesterproject/repositories/auth/auth_repository.dart';
import 'package:semesterproject/repositories/user/user_base_repository.dart';

import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => BlocProvider(
              create: (context) => ProfileBloc(
                authBloc: context.read<AuthBloc>(),
                userRepository: context.read<UserRepository>(),
              )..add(LoadProfile(
                  context.read<AuthBloc>().state.authUser,
                )),
              child: const ProfileScreen(),
            ));
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      bottomNavigationBar: const CustomNavbar(
        screen: routeName,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUSTOMER INFORMATION',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Email',
                    initialValue: state.user.email,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(email: value)));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'FullName',
                    initialValue: state.user.fullName,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(fullName: value)));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Address',
                    initialValue: state.user.address,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(address: value)));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'City',
                    initialValue: state.user.city,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(city: value)));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Country',
                    initialValue: state.user.country,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(country: value)));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Zip Code',
                    initialValue: state.user.zipCode,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                          user: state.user.copyWith(zipCode: value)));
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthRepository>().signOut();
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: const Text('Sign Out')),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'You\'re not logged in',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(),
                      fixedSize: const Size(200, 40)),
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
