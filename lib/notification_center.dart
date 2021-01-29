import 'package:flutter/cupertino.dart';

class NotificationCenter {
  static NotificationCenter _default = NotificationCenter();

  var _observerMap = Map();

  final _segmentKey = "jjw-tool-box";

  /// 添加监听
  /// observer 监听的对象
  /// name 监听的通知名称
  /// block 监听通知的回调
  static void addObserver({@required Object observer, @required String name, @required void block(Object param)}) {
    final key = name + NotificationCenter._default._segmentKey + observer.hashCode.toString();
    print(key);
    print(key.split(NotificationCenter._default._segmentKey));
    NotificationCenter._default._observerMap[key] = block;
  }

  /// 发送通知
  /// name 通知名称
  /// param 通知参数
  static void post({@required String name, Object param}) {
    NotificationCenter._default._observerMap.forEach((key, value) {
      final List array = key.split(NotificationCenter._default._segmentKey);
      if (array.length == 2) {
        final _name = array[0];
        if (_name == name && value != null) {
          value(param);
        }
      }
    });
  }

  /// 移除通知
  /// observer 要移除的对象
  /// name 移除的通知名称，如果为null，则移除这个observer下的所有对象
  static void removeObserver(Object observer, [String name]) {
    if (name != null) {
      final key = name + NotificationCenter._default._segmentKey + observer.hashCode.toString();
      NotificationCenter._default._observerMap.remove(key);
    } else {
      final keys = NotificationCenter._default._observerMap.keys;
      final List<String> keysToRemove = [];
      for (var key in keys) {
        final array = key.split(NotificationCenter._default._segmentKey);
        if (array.length == 2) {
          final hasCode = array[1];
          if (hasCode == observer.hashCode.toString()) {
            keysToRemove.add(key);
          }
        }
      }
      NotificationCenter._default._observerMap.removeWhere((key, value) => keysToRemove.contains(key));
    }
  }
}
