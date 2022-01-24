import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:simple_book_log/resource/model/enum/ios_identifier.dart';

class IosBottomSpace extends StatefulWidget {
  const IosBottomSpace({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IosBottomSpaceState();
}

class IosBottomSpaceState extends State<IosBottomSpace> {
  bool _needBottomSpace = true;
  static const double bottomSpacePx = 20;

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
  }

  Future<void> _fetchDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    String? machineIdentifier = iosInfo.utsname.machine;
    IosIdentifier machineVer = IosIdentifierExt.from(machineIdentifier);
    setState(() {
      _needBottomSpace = machineVer.existBottomBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_needBottomSpace) {
      return Container(
        height: bottomSpacePx,
        width: double.infinity,
        color: Colors.transparent,
      );
    } else {
      return Container();
    }
  }
}
