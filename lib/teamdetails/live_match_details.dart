import 'package:flutter/material.dart';
import 'package:nitusue/statistics/components/team.dart';
import 'package:nitusue/utils/models/match.dart';
import 'package:nitusue/utils/widget/background.dart';
import 'package:nitusue/utils/widget/constants.dart';
import 'package:nitusue/utils/widget/item_live_detail.dart';


class LiveMatchDetails extends StatefulWidget {
  final SoccerMatch match;
  const LiveMatchDetails({Key? key,required this.match}) : super(key: key);

  @override
  _LiveMatchDetailsState createState() => _LiveMatchDetailsState();
}

class _LiveMatchDetailsState extends State<LiveMatchDetails> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_PRIMARY,
        title: Text("Live Match Details"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          TransparentBackground(),
          Column(
            children: [
              //top header
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusStandard),
                  bottomRight: Radius.circular(radiusStandard),
                ),
                child: Container(
                  padding: const EdgeInsets.all(marginLarge),
                  // height: _size.height * 0.2,
                  width: double.infinity,
                  color: COLOR_PRIMARY,
                  child: Column(
                    children: [
                      //Live badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: COLOR_GREEN_LIGHT),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Live",
                          style: TextStyle(color: COLOR_GREEN_LIGHT),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TeamLogoName(
                            isHome: true,
                            width: _size.width * 0.2,
                            team: widget.match.home,
                          ),
                          Container(
                            width: _size.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   widget.match.goal.home.toString(),
                                //   style: TextStyle(
                                //       fontSize: fontSizexxLarge,
                                //       color: Colors.white),
                                // ),
                                // Text(
                                //   "-",
                                //   style: TextStyle(
                                //       fontSize: fontSizexxLarge,
                                //       color: Colors.white),
                                // ),
                                // Text(
                                //   widget.match.goal.away.toString(),
                                //   style: TextStyle(
                                //       fontSize: fontSizexxLarge,
                                //       color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                          TeamLogoName(
                            isHome: false,
                            width: _size.width * 0.2,
                            team: widget.match.away,
                          ),
                        ],
                      ),
                      Text(
                        "Time: ${widget.match.fixture.status.elapsedTime.toString()}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              //statistics list
              Expanded(
                child: ListView(
                  children: [
                    LiveDetailItem(
                      image: IMG_LEAGUE,
                      title: "League",
                      subTitle: widget.match.league.name,
                    ),
                    // LiveDetailItem(
                    //   image: IMG_VENUE,
                    //   title: "Venue",
                    //   subTitle: widget.match.fixture.venue.name,
                    //   subTitle2: widget.match.fixture.venue.city,
                    // ),
                    LiveDetailItem(
                      image: IMG_CLOCK,
                      title: "Status",
                      subTitle: widget.match.fixture.status.long,
                    ),
                    LiveDetailItem(
                      image: IMG_REFEREE,
                      title: "Referee",
                      subTitle: widget.match.fixture.referee,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
