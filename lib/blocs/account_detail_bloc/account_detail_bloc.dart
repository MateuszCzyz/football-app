import 'dart:async';

import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:FootballApp/resources/repositories/image_repository.dart';
import 'package:FootballApp/resources/repositories/users_repository.dart';
import 'package:FootballApp/utils/get_error_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:FootballApp/resources/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_detail_event.dart';
part 'account_detail_state.dart';

class AccountDetailBloc extends Bloc<AccountDetailEvent, AccountDetailState> {
  final AuthenticationRepository authenticationRepository;
  final UsersRepository usersRepository;
  final ArticleRepository articleRepository;
  final ImageRepository imageRepository;
  final BuildContext context;

  AccountDetailBloc(
      {this.authenticationRepository,
      this.usersRepository,
      this.articleRepository,
      this.imageRepository,
      this.context})
      : super(AccountDetailInitial());

  @override
  Stream<AccountDetailState> mapEventToState(
    AccountDetailEvent event,
  ) async* {
    yield LoadingAccountData();
    if (event is ChangeAccountEmail) {
      yield* changeAccountEmailToState(newEmail: event.email);
    } else if (event is SetNewNickname) {
      yield* setNewNicknameToState(newNickname: event.nickname);
    } else if (event is SetNewPassword) {
      yield* setNewPasswordToState(newPassword: event.password);
    } else if (event is TakeCameraPhoto) {
      yield* takeCameraPhotoToState();
    } else if (event is TakeGalleryPhoto) {
      yield* takeGalleryPhotoToState();
    } else if (event is RemoveCurrentPhoto) {
      yield* removeCurrentPhotoToState();
    } else if (event is DeleteAccount) {
      yield* deleteAccountToState();
    } else if (event is LogOut) {
      yield* logOutToState();
    } else {
      yield LoadingAccountData();
    }
  }

  Stream<AccountDetailState> changeAccountEmailToState(
      {String newEmail}) async* {
    try {
      await authenticationRepository.updateUserEmail(email: newEmail);
      await authenticationRepository.reloadAccount();
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield FailureUpdatedAccountData(errorMessage: _errorMessage);
    }
  }

  Stream<AccountDetailState> setNewPasswordToState(
      {String newPassword}) async* {
    try {
      await authenticationRepository.updateUserPassword(password: newPassword);
      await authenticationRepository.reloadAccount();
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield FailureUpdatedAccountData(errorMessage: _errorMessage);
    }
  }

  Stream<AccountDetailState> setNewNicknameToState(
      {String newNickname}) async* {
    try {
      await authenticationRepository.updateUserName(displayName: newNickname);
      await authenticationRepository.reloadAccount();
      await usersRepository.updateUserName(
          userID: authenticationRepository.getCurrentUser().uid,
          newUserName: newNickname);
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield FailureUpdatedAccountData(errorMessage: _errorMessage);
    }
  }

  Stream<AccountDetailState> logOutToState() async* {
    try {
      await authenticationRepository.signOut();
      BlocProvider.of<AuthenticationBloc>(context).add(LogoutAuthentication());
      yield SuccessAccountOperation();
    } catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield FailureUpdatedAccountData(errorMessage: _errorMessage);
    }
  }

  Stream<AccountDetailState> deleteAccountToState() async* {
    try {
      BlocProvider.of<AuthenticationBloc>(context).add(UpdatingAccountData());
      String _currentUserID = authenticationRepository.getCurrentUser().uid;
      await authenticationRepository.deleteAccount();
      await usersRepository.removeUser(userID: _currentUserID);
      await articleRepository.removeAllUserComments(userID: _currentUserID);
      await imageRepository.removeImage(userID: _currentUserID);
      BlocProvider.of<AuthenticationBloc>(context).add(LogoutAuthentication());
      yield SuccessAccountOperation();
    } catch (e) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      String _errorMessage = getErrorMessage(e.code);
      yield FailureUpdatedAccountData(errorMessage: _errorMessage);
    }
  }

  Stream<AccountDetailState> takeCameraPhotoToState() async* {
    try {
      await authenticationRepository.setUserPhotoByCamera();
      await authenticationRepository.reloadAccount();
      User _currentUser = authenticationRepository.getCurrentUser();
      await usersRepository.updateUserPhoto(
          userID: _currentUser.uid, newImagePath: _currentUser.photoURL);
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      yield FailureUpdatedAccountData(errorMessage: 'Camera has been closed');
    }
  }

  Stream<AccountDetailState> takeGalleryPhotoToState() async* {
    try {
      await authenticationRepository.setUserPhotoByGallery();
      await authenticationRepository.reloadAccount();
      User _currentUser = authenticationRepository.getCurrentUser();
      await usersRepository.updateUserPhoto(
          userID: _currentUser.uid, newImagePath: _currentUser.photoURL);
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      yield FailureUpdatedAccountData(
          errorMessage: 'The images gallery has been closed');
    }
  }

  Stream<AccountDetailState> removeCurrentPhotoToState() async* {
    try {
      await authenticationRepository.removeUserPhoto();
      await authenticationRepository.reloadAccount();
      await usersRepository.removeUserPhoto(
          userID: authenticationRepository.getCurrentUser().uid);
      BlocProvider.of<AuthenticationBloc>(context)
          .add(CheckAuthenticationStatus());
      yield SuccessUpdatedAccountData();
    } catch (e) {
      yield FailureUpdatedAccountData(errorMessage: 'Cannot remove the image');
    }
  }
}
