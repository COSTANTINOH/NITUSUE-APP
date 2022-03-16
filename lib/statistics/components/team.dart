import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nitusue/utils/models/team.dart';
import 'package:nitusue/utils/widget/constants.dart';

class TeamLogoName extends StatelessWidget {
  final Team team;
  final double width;
  final bool isHome;
  const TeamLogoName({
    Key? key,
    required this.team,
    required this.width,
    required this.isHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isHome ? "Home" : "Away",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: marginLarge),
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: team.logoUrl,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: marginLarge),
          Text(
            team.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: fontSizeStandard),
          ),
        ],
      ),
    );
  }
}
