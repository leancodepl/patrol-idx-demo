import 'package:patrol/patrol.dart';
import 'package:patrol_challenge/main.dart';

void main() {
  patrolTest(
    'test',
    ($) async {
      await initApp();
      await $.pumpWidgetAndSettle(const MyApp());

      if (await $.platform.mobile.isPermissionDialogVisible()) {
        await $.platform.mobile.grantPermissionWhenInUse();
      }

      await $('Send notification').tap();

      if (await $.platform.mobile.isPermissionDialogVisible()) {
        await $.platform.mobile.grantPermissionWhenInUse();
      }

      await $.platform.mobile.openNotifications();

      await $.platform.mobile.openNotifications();

      await $.platform.mobile
          .tapOnNotificationBySelector(Selector(textContains: 'Tap'));
      try {
        await $.platform.android
            .tap(AndroidSelector(textContains: 'Turn on location'));
      } catch (e) {
        // ignore exception
      }

      await $(RegExp('Your location')).waitUntilVisible(
        timeout: const Duration(seconds: 30),
      );
    },
  );
}
