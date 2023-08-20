import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotifHelper {
  NotifHelper._();

  static Future<void> initNotif() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.setAppId('aedc7131-0a37-46a2-af45-66cfa65604b8');

    OneSignal.shared.promptUserForPushNotificationPermission().then(
        (puhNotificationPermission) =>
            {log("Permission Accepted $puhNotificationPermission")});
  }
}
