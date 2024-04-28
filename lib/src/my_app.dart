import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_ui/taav_ui.dart';

import '../localization_service.dart';
import 'infrastructiors/route/route_names.dart';
import 'infrastructiors/route/route_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        getPages: RoutPages.pages,
        initialRoute: RouteNames.personList,
        debugShowCheckedModeBanner: false,
        builder: _builder,
        locale: const Locale('en', 'US'),
        translationsKeys: LocalizationService.keys,
      );

  Widget _builder(_, Widget? child) => TaavTheme(
        theme: TaavThemeBuilder().styleData,
        child: TaavToast(
          toastAlignment: Alignment.topCenter,
          child: child!,
        ),
      );
}
