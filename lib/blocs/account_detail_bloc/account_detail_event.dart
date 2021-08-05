part of 'account_detail_bloc.dart';

abstract class AccountDetailEvent extends Equatable {
  const AccountDetailEvent();

  @override
  List<Object> get props => [];
}

class ChangeAccountEmail extends AccountDetailEvent {
  final String email;

  ChangeAccountEmail({this.email});
}

class SetNewPassword extends AccountDetailEvent {
  final String password;

  SetNewPassword({this.password});
}

class SetNewNickname extends AccountDetailEvent {
  final String nickname;

  SetNewNickname({this.nickname});
}

class TakeCameraPhoto extends AccountDetailEvent {}

class TakeGalleryPhoto extends AccountDetailEvent {}

class RemoveCurrentPhoto extends AccountDetailEvent {}

class DeleteAccount extends AccountDetailEvent {}

class LogOut extends AccountDetailEvent {}
