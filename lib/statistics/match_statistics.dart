import 'package:flutter/material.dart';
import 'package:nitusue/statistics/components/row.dart';
import 'package:nitusue/statistics/components/team.dart';
import 'package:nitusue/utils/api/soccer_api.dart';
import 'package:nitusue/utils/models/match.dart';
import 'package:nitusue/utils/models/statistic.dart';
import 'package:nitusue/utils/widget/background.dart';
import 'package:nitusue/utils/widget/constants.dart';


class MatchStatistics extends StatefulWidget {
  final SoccerMatch match;
  const MatchStatistics({Key? key,required this.match}) : super(key: key);

  @override
  _MatchStatisticsState createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  late List<Statistic> homeStatistics;
  late List<Statistic> awayStatistics;
  var _isLoading = false;
  var _homeStatLength = 0;
  var _awayStatLength = 0;
  @override
  void initState() {
    super.initState();
    getStatistics();
  }

  void getStatistics() async {
    isLoading = true;
    homeStatistics = await SoccerApi.getTeamStatistics(
        widget.match.fixture.id, widget.match.home.id);

    awayStatistics = await SoccerApi.getTeamStatistics(
        widget.match.fixture.id, widget.match.away.id);
    isLoading = false;
    _homeStatLength = homeStatistics.length;
    _awayStatLength = awayStatistics.length;
    // print("Home:: homestats :: ${homeStatistics.statistics.toList()}");
    // print("Home:: awaystats :: ${awayStatistics.statistics.toList()}");
  }

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _statLength =
        _homeStatLength >= _awayStatLength ? _awayStatLength : _homeStatLength;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_PRIMARY,
        title: Text("Fixture Statistics"),
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
                  padding:  EdgeInsets.all(marginLarge),
                  // height: _size.height * 0.2,
                  width: double.infinity,
                  color: COLOR_PRIMARY,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.match.fixture.date.substring(0, 10),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TeamLogoName(
                            isHome: true,
                            width: _size.width * 0.25,
                            team: widget.match.home,
                          ),
                          Container(
                            width: _size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.match.goal.home.toString(),
                                  style: TextStyle(
                                      fontSize: fontSizexxLarge,
                                      color: Colors.white),
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: fontSizexxLarge,
                                      color: Colors.white),
                                ),
                                Text(
                                  widget.match.goal.away.toString(),
                                  style: TextStyle(
                                      fontSize: fontSizexxLarge,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          TeamLogoName(
                            isHome: false,
                            width: _size.width * 0.25,
                            team: widget.match.away,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //statistics list
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _statLength,
                        itemBuilder: (ctx, index) {
                          return StatisticRow(
                            // home: 2,
                            // away: 3,
                            // title: "tiot",
                            home: homeStatistics[index].value,
                            away: awayStatistics[index].value,
                            title: homeStatistics[index].type,
                          );
                        },
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
