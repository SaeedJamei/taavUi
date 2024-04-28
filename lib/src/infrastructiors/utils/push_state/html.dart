import 'dart:html';

class PushStates {
  static void pushState(final String title, final String? url) {
    window.history.pushState(
      null,
      title,
      url,
    );
  }
}
