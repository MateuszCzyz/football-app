import 'package:FootballApp/ui/screens/home_screen/local_widgets/about_application_drawer_button.dart';
import 'package:FootballApp/ui/screens/home_screen/local_widgets/login_drawer_button.dart';
import 'package:FootballApp/ui/screens/home_screen/local_widgets/logout_drawer_button.dart';
import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:FootballApp/ui/global_widgets/account_image_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'settings_drawer_button.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is SuccesAuthentication) {
            return SignedInDrawer(
              currentUser: state.user!,
            );
          } else if (state is FailureAuthentication) {
            return SignedOutDrawer();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SignedInDrawer extends StatelessWidget {
  final User currentUser;

  SignedInDrawer({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SignedInNavBar(
          currentUser: currentUser,
        ),
        SignedInBottomBar(
          currentUser: currentUser,
        )
      ],
    );
  }
}

class SignedOutDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [SignedOutNavBar(), SignedOutBottomBar()],
    );
  }
}

class SignedInNavBar extends StatelessWidget {
  final User currentUser;

  SignedInNavBar({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AccountImage(
                  heroTag: 'drawer_account_image',
                  size: 60,
                  imagePath: currentUser.photoURL!,
                  userHasImage: currentUser.photoURL != null ? true : false,
                  displayName: currentUser.displayName!,
                  fontSize: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser.displayName!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15),
                      ),
                      Text(currentUser.email!,
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class SignedOutNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              Text(
                'You are not logged in',
              ),
              Padding(padding: EdgeInsets.all(15), child: Divider())
            ],
          )),
    );
  }
}

class SignedInBottomBar extends StatelessWidget {
  final User currentUser;

  SignedInBottomBar({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsets.all(15), child: Divider()),
            SettingsDrawerButton(
              user: currentUser,
            ),
            AboutApplicationDrawerButton(),
            LogoutDrawerButton()
          ],
        ),
      ),
    );
  }
}

class SignedOutBottomBar extends StatelessWidget {
  final User? currentUser;

  SignedOutBottomBar({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsets.all(15), child: Divider()),
            AboutApplicationDrawerButton(),
            LoginDrawerButton()
          ],
        ),
      ),
    );
  }
}
