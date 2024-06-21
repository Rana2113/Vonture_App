part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserModel user;

  SignUpSuccess(this.user);
}

final class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure(this.message);
}

class SignUpSelectValueState extends SignUpState {}

final class GetSkillsLoadingState extends SignUpState {}

final class GetSkillsSuccessState extends SignUpState {
  final List<Requirements> skills;

  GetSkillsSuccessState(
      {required this.skills});
}

final class GetSkillsErrorState extends SignUpState {
  final String message;
  GetSkillsErrorState({required this.message});
}
