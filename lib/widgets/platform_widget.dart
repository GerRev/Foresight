
import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {

  Widget cupertinoWidget(BuildContext context);
  Widget materialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return cupertinoWidget(context);
    }
    return materialWidget(context);
  }
}
