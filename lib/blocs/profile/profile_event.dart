part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> props() => [];
}

class LoadProfile extends ProfileEvent {
  final auth.User? authUser;

  const LoadProfile(this.authUser);
  @override
  List<Object?> props() => [authUser];
}

class UpdateProfile extends ProfileEvent {
  final User? user;

  const UpdateProfile({this.user});
  @override
  List<Object?> props() => [user];
}
