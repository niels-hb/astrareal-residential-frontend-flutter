import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../brandings/branding.dart';
import '../../build_information/build_information.dart';
import '../../providers/api.dart';
import '../../providers/authentication.dart';
import '../../util/validator.dart';
import '../../widgets/loading_button.dart';
import '../home/page.dart';
import '../management_home/page.dart';
import '../sign_up/page.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  static const String route = '/sign_in';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(32.0),
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
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          autocorrect: false,
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.badge),
                            labelText: AppLocalizations.of(context)!
                                .emailOrTelephoneNumber,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.usernameValidator(value),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            labelText: AppLocalizations.of(context)!.password,
                          ),
                          validator: (String? value) =>
                              Validator.of(context).getErrorMessage(
                            validationResults: (Validator v) =>
                                v.passwordValidator(value),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: LoadingButton<void>(
                            onPressed: () => _signIn(context, ref),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .signIn
                                  .toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  onPressed: () => _signUp(context),
                  child: Text(
                    AppLocalizations.of(context)!.signUpHint,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context, WidgetRef ref) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final Api api = ref.read(apiProvider);

    try {
      await api.oAuth2.passwordLogin(
        _usernameController.text,
        _passwordController.text,
      );

      ref.invalidate(authenticatedUserProvider);

      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(
          buildInformation.buildType == BuildType.user
              ? HomePage.route
              : ManagementHomePage.route,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void _signUp(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpPage.route);
  }
}
