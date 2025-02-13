import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'brandings/branding.dart';
import 'brandings/customer.dart';
import 'build_information/build_information.dart';
import 'residential_app.dart';

void main() {
  BuildInformation.init(
    apiBaseUrl: kReleaseMode
        ? 'https://vinhomes-api.astrareal.tech'
        : 'http://localhost:8080',
    buildType: BuildType.management,
  );

  runApp(
    Branding(
      customer: Customer.vinhomes,
      child: const ResidentialApp(),
    ),
  );
}
