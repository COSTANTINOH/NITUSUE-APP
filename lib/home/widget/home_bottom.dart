import 'package:flutter/material.dart';
import 'package:nitusue/utils/models/league.dart';
import 'package:nitusue/utils/widget/constants.dart';

class HomeBottom extends StatelessWidget {
  final double height;
  final Function onViewAllTap;
  final ValueSetter<League> onLeagueTap;
  const HomeBottom({Key? key, required this.height, required this.onViewAllTap, required this.onLeagueTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _leagues = League.leagues;
    return Container(
      height: height,
      margin: const EdgeInsets.only(right: marginxLarge),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radiusStandard),
          bottomRight: Radius.circular(radiusStandard),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(marginLarge),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Timu Pendwa",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: fontSizeSmall,
                    ),
                  ),
                ),
                InkWell(
                  // onTap: onViewAllTap,
                  child: Visibility(
                    visible: onViewAllTap != null,
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: fontSizeStandard,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                // height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _leagues.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        onLeagueTap(_leagues[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: marginLarge,
                        ),
                        width: 55,
                        height: 55,
                        child: Image.asset(_leagues[index].logo),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
