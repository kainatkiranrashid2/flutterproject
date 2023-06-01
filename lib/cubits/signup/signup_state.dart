part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String password;
  final SignupStatus status;
  final auth.User? authUser;
  final User? user;
  const SignupState(
      {required this.password, required this.status, this.authUser, this.user});

  bool get isFormValid => user!.email.isNotEmpty && password.isNotEmpty;

  factory SignupState.initial() {
    return SignupState(
        password: '',
        status: SignupStatus.initial,
        authUser: null,
        user: User());
  }

  SignupState copyWith({
    String? password,
    SignupStatus? status,
    User? user,
    auth.User? authUser,
  }) {
    return SignupState(
        password: password ?? this.password,
        authUser: authUser ?? this.authUser,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  bool get stringify => true;
  @override
  List<Object?> props() => [password, status, authUser, user];
}

// class SignupInitial extends SignupState {}
