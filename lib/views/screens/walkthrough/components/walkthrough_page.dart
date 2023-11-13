import 'package:flutter/material.dart';

import 'walkthrough_widget.dart';

class WalkthroughPage extends StatelessWidget {
  const WalkthroughPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WalkthroughWidget(
      image: 'images/walkthrough.png',
      heading: 'Wherever you are health is number one',
      text: 'There is no instant way to a healthy life.',
    );
  }
}
