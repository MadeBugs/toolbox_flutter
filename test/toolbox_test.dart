import 'package:flutter_test/flutter_test.dart';
import 'package:toolbox/notification_center.dart';

void main() {
  NotificationCenter.addObserver(observer: "qwe", name: "test_noti", block: (value) {});
  test('adds one to input values', () {});
}
