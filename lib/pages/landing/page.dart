import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../brandings/branding.dart';
import '../../build_information/build_information.dart';
import '../../models/account.dart';
import '../../providers/authentication.dart';
import '../home/page.dart';
import '../management_home/page.dart';
import '../sign_in/page.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  static const String route = '/landing';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Account?> isAuthenticated =
        ref.watch(authenticatedUserProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 250.0,
              child: Hero(
                tag: Branding.of(context).logo,
                child: Image.asset(Branding.of(context).logo),
              ),
            ),
            const SizedBox(height: 16.0),
            isAuthenticated.when(
              loading: () => const CircularProgressIndicator.adaptive(),
              data: (Account? authenticatedUser) {
                Future<void>.microtask(
                  () => Navigator.of(context).pushReplacementNamed(
                    authenticatedUser != null
                        ? buildInformation.buildType == BuildType.user
                            ? HomePage.route
                            : ManagementHomePage.route
                        : SignInPage.route,
                  ),
                );

                return Container();
              },
              error: (Object error, StackTrace stackTrace) => Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
