import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// class HelpScreen extends StatelessWidget {
//   const HelpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         width: MediaQuery.of(context).size.width * 0.75,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: AppColors.primary,
//             width: 4,
//           ),
//           color: AppColors.surface,
//         ),
//         child: Column(
//           children: [
//             Text(
//               "Todo Hero",
//               style: AppTextStyles.title,
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.05,
//             ),
//             Container(
//               /*height: 0.80,
//               width: 0.75,*/
//               child: Column(
//                 children: [
//                   Text(
//                     "Welcome to Todo Hero!",
//                     style: AppTextStyles.caption,
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "- Mark down new Quests\n- Finish Quests to Perform Actions\n- Explore the Valkeia Dungeon!",
//                     style: AppTextStyles.body,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              "Todo Hero",
              style: AppTextStyles.title,
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Text(
                  "Welcome to Todo Hero!",
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "- Mark down new Quests\n- Finished Quests fill Action Meter\n- Explore the Valkeia Dungeon!",
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}