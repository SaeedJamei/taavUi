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
        initialRoute: RouteNames.viewPage,
        debugShowCheckedModeBanner: false,
         builder: (final context, final child) => TaavTheme(
          theme: TaavThemeBuilder().styleData,
          child: TaavToast(
            toastAlignment: Alignment.topCenter,
            child: child!,
          ),
        ),
        locale: const Locale('en', 'US'),
        translationsKeys: LocalizationService.keys,
      );

}
