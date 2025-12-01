import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/auth/presentation/screens/widgets/init_screen_bar.dart';

class InitScreenBody extends StatelessWidget {
  const InitScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              AssetsData.person2,
              width: 300,
              height: 300,
              alignment: Alignment.bottomLeft,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We are here",
                  style: Styles.textStyle18,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                Text(
                  "All your memories are stored safely. Accessable in any Time!",
                  style: Styles.textStyle16,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: KMainColor, width: 1),
                  ),
                  child: InitScreenBar(width: width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
