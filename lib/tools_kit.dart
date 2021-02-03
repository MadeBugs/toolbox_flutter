class ToolsKit {
  /// 比较版本号大小
  /// 如果 version1 > version2 ，true；
  /// else false；
  static bool compareVersion(String version1, String version2) {
    if (_Version(version1) > _Version(version2)) {
      return true;
    }
    return false;
  }
}

class _Version {
  /// 主版本号
  int major;

  /// 次版本号
  int minor;

  /// 修正版本号
  int revision;

  /// 支持格式如： 3.2.2
  _Version(String version) {
    final list = version.split('.');
    this.major = int.parse(list[0]);
    this.minor = int.parse(list[1]);
    this.revision = int.parse(list[2]);
  }

  bool operator >(_Version version) {
    if (this.major > version.major) {
      return true;
    } else if (this.minor > version.minor) {
      return true;
    } else if (this.revision > version.revision) {
      return true;
    }
    return false;
  }

  bool operator <(_Version version) {
    if (this.major < version.major) {
      return true;
    } else if (this.minor < version.minor) {
      return true;
    } else if (this.revision < version.revision) {
      return true;
    }
    return false;
  }

  /// 在高版本Dart中，Object中已经重载了==,所以需要加上covariant关键字重写这个重载函数
  @override
  bool operator ==(covariant _Version version) {
    if (this.major == version.major && this.minor == version.minor && this.revision == version.revision) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
