enum IosIdentifier {
  iPhone,
  iPhone3G,
  iPhone3GS,
  iPhone4,
  iPhone4S,
  iPhone5,
  iPhone5c,
  iPhone5s,
  iPhone6,
  iPhone6Plus,
  iPhone6s,
  iPhone6sPlus,
  iPhoneSE1st,
  iPhone7,
  iPhone7Plus,
  iPhone8,
  iPhone8Plus,
  iPhoneX,
  iPhoneXR,
  iPhoneXS,
  iPhoneXSMax,
  iPhone11,
  iPhone11Pro,
  iPhone11ProMax,
  iPhoneSE2nd,
  iPhone12mini,
  iPhone12,
  iPhone12Pro,
  iPhone12ProMax,
  other
}

extension IosIdentifierExt on IosIdentifier {
  bool existBottomBar() {
    switch (this) {
      case IosIdentifier.iPhone:
      case IosIdentifier.iPhone3G:
      case IosIdentifier.iPhone3GS:
      case IosIdentifier.iPhone4:
      case IosIdentifier.iPhone4S:
      case IosIdentifier.iPhone5:
      case IosIdentifier.iPhone5s:
      case IosIdentifier.iPhone5c:
      case IosIdentifier.iPhone6:
      case IosIdentifier.iPhone6Plus:
      case IosIdentifier.iPhone6s:
      case IosIdentifier.iPhone6sPlus:
      case IosIdentifier.iPhoneSE1st:
      case IosIdentifier.iPhone7:
      case IosIdentifier.iPhone7Plus:
      case IosIdentifier.iPhone8:
      case IosIdentifier.iPhone8Plus:
      case IosIdentifier.iPhoneSE2nd:
        return false;
      case IosIdentifier.iPhoneX:
      case IosIdentifier.iPhoneXR:
      case IosIdentifier.iPhoneXS:
      case IosIdentifier.iPhoneXSMax:
      case IosIdentifier.iPhone11:
      case IosIdentifier.iPhone11Pro:
      case IosIdentifier.iPhone11ProMax:
      case IosIdentifier.iPhone12mini:
      case IosIdentifier.iPhone12:
      case IosIdentifier.iPhone12Pro:
      case IosIdentifier.iPhone12ProMax:
      case IosIdentifier.other:
        return true;
    }
  }

  static IosIdentifier from(String? identifier) {
    switch (identifier) {
      case "iPhone1,1":
        return IosIdentifier.iPhone;
      case "iPhone1,2":
        return IosIdentifier.iPhone3G;
      case "iPhone2,1":
        return IosIdentifier.iPhone3GS;
      case "iPhone3,1":
      case "iPhone3,2":
      case "iPhone3,3":
        return IosIdentifier.iPhone4;
      case "iPhone4,1":
        return IosIdentifier.iPhone4S;
      case "iPhone5,1":
      case "iPhone5,2":
        return IosIdentifier.iPhone5;
      case "iPhone5,3":
      case "iPhone5,4":
        return IosIdentifier.iPhone5c;
      case "iPhone6,1":
      case "iPhone6,2":
        return IosIdentifier.iPhone5s;
      case "iPhone7,2":
        return IosIdentifier.iPhone6;
      case "iPhone7,1":
        return IosIdentifier.iPhone6Plus;
      case "iPhone8,1":
        return IosIdentifier.iPhone6s;
      case "iPhone8,2":
        return IosIdentifier.iPhone6sPlus;
      case "iPhone8,4":
        return IosIdentifier.iPhoneSE1st;
      case "iPhone9,1":
      case "iPhone9,3":
        return IosIdentifier.iPhone7;
      case "iPhone9,2":
      case "iPhone9,4":
        return IosIdentifier.iPhone7Plus;
      case "iPhone10,1":
      case "iPhone10,4":
        return IosIdentifier.iPhone8;
      case "iPhone10,2":
      case "iPhone10,5":
        return IosIdentifier.iPhone8Plus;
      case "iPhone10,3":
      case "iPhone10,6":
        return IosIdentifier.iPhoneX;
      case "iPhone11,8":
        return IosIdentifier.iPhoneXR;
      case "iPhone11,2":
        return IosIdentifier.iPhoneXS;
      case "iPhone11,6":
      case "iPhone11,4":
        return IosIdentifier.iPhoneXSMax;
      case "iPhone12,1":
        return IosIdentifier.iPhone11;
      case "iPhone12,3":
        return IosIdentifier.iPhone11Pro;
      case "iPhone12,5":
        return IosIdentifier.iPhone11ProMax;
      case "iPhone12,8":
        return IosIdentifier.iPhoneSE2nd;
      case "iPhone13,1":
        return IosIdentifier.iPhone12mini;
      case "iPhone13,2":
        return IosIdentifier.iPhone12;
      case "iPhone13,3":
        return IosIdentifier.iPhone12Pro;
      case "iPhone13,4":
        return IosIdentifier.iPhone12ProMax;
      default:
        // TODO: ログを残すことで iOS が更新されたことを検知できるようにする
        return IosIdentifier.other;
    }
  }
}
