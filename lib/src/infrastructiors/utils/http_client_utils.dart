import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';
import 'package:taav_ui/taav_ui.dart';

class HttpClientUtils {
  static TaavHttpClient httpClient({
    final String? baseUrl,
  }) =>
      TaavHttpClient(
        onExceptionThrown: (final exception) => TaavToastManager().showToast(
          exception,
          status: TaavWidgetStatus.danger,
        ),
        baseUrl: baseUrl ?? 'https://geographyapi.taavstage.ir',
      );
}
