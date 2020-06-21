import 'package:belajar_bloc/utils/const/const.dart';
import 'package:flutter/material.dart';

class GeneralFunction {
  static getPlatformIcon(int platformId) {
    switch (platformId) {
      case XBOX_ONE:
        return Image.asset('assets/images/icons/xbox_one.png');
      case XBOX_360:
        return Image.asset('assets/images/icons/xbox_360.png');
      case PC:
        return Image.asset('assets/images/icons/windows.png');
      case LINUX:
        return Image.asset('assets/images/icons/linux.png');
      case MAC_OS:
        return Image.asset('assets/images/icons/apple.png');
      case IOS:
        return Image.asset('assets/images/icons/ios.png');
      case PLAYSTATION_2:
        return Image.asset('assets/images/icons/playstation_2.png');
      case PLAYSTATION_3:
        return Image.asset('assets/images/icons/playstation_3.png');
      case PLAYSTATION_4:
        return Image.asset('assets/images/icons/playstation_4.png');
      case PLAYSTATION_5:
        return Image.asset('assets/images/icons/playstation_5.png');
      case ANDROID:
        return Image.asset('assets/images/icons/android.png');
      case PSP:
        return Image.asset('assets/images/icons/psp.png');
      case PS_VITA:
        return Image.asset('assets/images/icons/psvita.png');
      case NINTENDO_SWITCH:
        return Image.asset('assets/images/icons/switch.png');
      case NINTENDO_DS:
        return Image.asset('assets/images/icons/nintendo.png');

      default:
        return Image.asset('assets/images/icons/no_image.png');
    }
  }
}
