import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';

void main() {
  patrolTest(
    'test',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      await initApp();
      await $.pumpWidgetAndSettle(const MyApp());

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }

      await $('Send notification').tap();

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }

      await $.native.openNotifications();

      await $.native.openNotifications();

      await $.native.tapOnNotificationBySelector(Selector(textContains: 'Tap'));

      await $(RegExp('Your location')).waitUntilVisible(
        timeout: const Duration(seconds: 30),
      );
    },
  );
}
