import 'package:taav_ui/generated/locales.g.dart' as ui;

//ignore_for_file:prefer-correct-identifier-length
class LocalizationService {
  static const Map<String, String> fa = {
        ...ui.Locales.fa,
      },
      en = {
        ...ui.Locales.en,
      },
      ar = {
        ...ui.Locales.ar,
      };

  static const Map<String, Map<String, String>> keys = {
    'fa': fa,
    'en': en,
    'ar': ar,
  };
}
