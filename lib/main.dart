import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:pssn/application.dart';
import 'package:pssn/common/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await runZoned(
    () async {
      Bloc.observer = getIt();
      usePathUrlStrategy();
      runApp(
        ScreenUtilInit(
          minTextAdapt: true,
          designSize: const Size(385, 812),
          builder: (_, __) => const Application(),
        ),
      );
    },
  );
} 
