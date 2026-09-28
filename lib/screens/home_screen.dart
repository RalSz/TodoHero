import 'package:flutter/material.dart';

import '../widgets/quest_sheet.dart';
//import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.asset('assets/images/DungeonRoom1-4.png',
            fit: BoxFit.fitHeight,
            alignment: Alignment.topCenter,
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.27,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Image.asset('assets/images/Knight-Test.png',
            height: MediaQuery.of(context).size.height * 0.25,
            fit: BoxFit.contain,
          ),
        ),
        const QuestSheet(),
      ],
    );
  }
}
