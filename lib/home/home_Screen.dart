import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nitusue/home/widget/home_bottom.dart';
import 'package:nitusue/home/widget/home_top.dart';
import 'package:nitusue/home/widget/list_live_matches.dart';
import 'package:nitusue/teamdetails/league_fixtures.dart';
import 'package:nitusue/teamdetails/league_teams.dart';
import 'package:nitusue/utils/api/soccer_api.dart';
import 'package:nitusue/utils/drawer/drawer.dart';
import 'package:nitusue/utils/models/match.dart';
import 'package:nitusue/utils/widget/background.dart';
import 'package:nitusue/utils/widget/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Function opt, opt2;
  bool _showDrawer = false;

  void showDrawer() {
    print('tapped on show drawer!');
    setState(() {
      _showDrawer = !_showDrawer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xff222232),
          body: SafeArea(
            child: Container(
              color: Color(0xff222232),
              child: Stack(
                children: [
                  TransparentBackground(),
                  Column(
                    children: [
                      Container(
                        //app bar
                        height: 50,
                        color: Color(0xff222232),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    showDrawer();
                                  },
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "NITUSUE BET",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizexLarge,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      HomeTop(
                        onViewAllTap: () {},
                        onLeagueTap: (league) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => LeagueFixtures(
                                league: league,
                              ),
                            ),
                          );
                        },
                        height: _size.height * 0.22,
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: SoccerApi.getLiveMatches(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState == ConnectionState.active ||
                                snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("An Error occurred !"),
                              );
                            }

                            final List<SoccerMatch> liveMatches = snapshot.data as List<SoccerMatch>;
                            return LiveMatchesList(
                              liveMatches: liveMatches,
                              onTap: () {},
                              onViewAllTap: () {},
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      HomeBottom(
                        onViewAllTap: () {},
                        onLeagueTap: (league) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => LeagueTeams(league: league),
                            ),
                          );
                        },
                        height: _size.height * 0.22,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showDrawer)
          DrawerWidget(
            closeFunction: showDrawer,
          ),
      ],
    );
  }
}

class SportCard extends StatelessWidget {
  const SportCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 80,
          height: 23,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: Image.asset(
                    'assets/images/soccer.png',
                  ),
                ),
              ),
              SizedBox(width: 6),
              Text(
                "Football",
                style: GoogleFonts.sourceSansPro(color: Color(0xff181829), fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
