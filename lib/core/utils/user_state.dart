import 'package:flutter/foundation.dart';

class UserState {
  // Global notifier that can be used to notify listeners when the user profile changes.
  static final ValueNotifier<bool> profileUpdatedNotifier = ValueNotifier(
    false,
  );

  static void notifyProfileUpdated() {
    profileUpdatedNotifier.value = !profileUpdatedNotifier.value;
  }
}
