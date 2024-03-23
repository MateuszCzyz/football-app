part of 'account_detail_bloc.dart';

abstract class AccountDetailState extends Equatable {
  const AccountDetailState();

  @override
  List<Object> get props => [];
}

class AccountDetailInitial extends AccountDetailState {}

class SuccessUpdatedAccountData extends AccountDetailState {
  final User? currentUser;
  SuccessUpdatedAccountData({this.currentUser});
}

class FailureUpdatedAccountData extends AccountDetailState {
  final String errorMessage;

  FailureUpdatedAccountData({required this.errorMessage});
}

class LoadingAccountData extends AccountDetailState {}

class SuccessAccountOperation extends AccountDetailState {}
