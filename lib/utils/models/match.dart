import 'package:nitusue/utils/models/fixture.dart';
import 'package:nitusue/utils/models/goal.dart';
import 'package:nitusue/utils/models/league.dart';
import 'package:nitusue/utils/models/team.dart';

class SoccerMatch {
  Fixture fixture;
  Team home;
  Team away;
  // Goal goal;
  League league;
  SoccerMatch(this.fixture, this.home, this.away, this.league);

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    return SoccerMatch(
      Fixture.fromJson(json['fixture']),
      Team.fromJson(
        json['teams']['home'],
      ),
      Team.fromJson(json['teams']['away']),
      // Goal.fromJson(json['goals']),
      League.fromJson(json['league']),
    );
  }
}
