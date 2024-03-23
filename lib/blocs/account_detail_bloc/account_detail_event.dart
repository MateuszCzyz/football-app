part of 'account_detail_bloc.dart';

abstract class AccountDetailEvent extends Equatable {
  const AccountDetailEvent();

  @override
  List<Object> get props => [];
}

class ChangeAccountEmail extends AccountDetailEvent {
  final String email;

  ChangeAccountEmail({required this.email});
}

class SetNewPassword extends AccountDetailEvent {
  final String password;

  SetNewPassword({required this.password});
}

class SetNewNickname extends AccountDetailEvent {
  final String nickname;

  SetNewNickname({required this.nickname});
}

class TakeCameraPhoto extends AccountDetailEvent {}

class TakeGalleryPhoto extends AccountDetailEvent {}

class RemoveCurrentPhoto extends AccountDetailEvent {}

class DeleteAccount extends AccountDetailEvent {}

class LogOut extends AccountDetailEvent {}
