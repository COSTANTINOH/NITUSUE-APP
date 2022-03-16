import 'package:flutter/material.dart';
import 'package:nitusue/utils/widget/constants.dart';

class NoLiveMatches extends StatelessWidget {
  final double height;
  const NoLiveMatches({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(marginLarge),
      margin: EdgeInsets.symmetric(
        horizontal: marginxLarge,
        vertical: marginStandard,
      ),
      decoration: BoxDecoration(
        color: Color(0x5565FFED),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/images/schedule.png"),
          Text(
            "No Live Matches right now !",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
