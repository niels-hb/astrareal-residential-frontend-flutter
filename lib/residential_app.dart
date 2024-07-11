import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'brandings/branding.dart';
import 'pages/add_lease/page.dart';
import 'pages/add_project/page.dart';
import 'pages/add_request/page.dart';
import 'pages/home/page.dart';
import 'pages/landing/page.dart';
import 'pages/management_home/page.dart';
import 'pages/sign_in/page.dart';
import 'pages/sign_up/page.dart';

class ResidentialApp extends StatelessWidget {
  const ResidentialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Branding branding = Branding.of(context);

    return ProviderScope(
      child: MaterialApp(
        title: branding.title,
        theme: branding.lightTheme,
        darkTheme: branding.darkTheme,
        initialRoute: LandingPage.route,
        routes: <String, Widget Function(BuildContext)>{
          LandingPage.route: (BuildContext context) => const LandingPage(),
          SignInPage.route: (BuildContext context) => SignInPage(),
          SignUpPage.route: (BuildContext context) => SignUpPage(),
          HomePage.route: (BuildContext context) => const HomePage(),
          AddRequestPage.route: (BuildContext context) =>
              const AddRequestPage(),
          AddLeasePage.route: (BuildContext context) => AddLeasePage(),
          ManagementHomePage.route: (BuildContext context) =>
              const ManagementHomePage(),
          AddProjectPage.route: (BuildContext context) => AddProjectPage(),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
