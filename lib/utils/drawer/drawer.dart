import 'package:flutter/material.dart';
import 'package:nitusue/utils/drawer/drawer_collapse.dart';
import 'package:nitusue/utils/drawer/drawer_item.dart';
import 'package:nitusue/utils/drawer/drawer_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key, required this.closeFunction}) : super(key: key);
  final Function closeFunction;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double height;
  late double width;
  double backgroundOpacity = 0;
  bool isCollapsed = true;
  bool isCollapsedAfterSec = true;

  void initializeAnimation() {
    _controller = AnimationController(
      duration: Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );
    startAnimation();
  }

  void startAnimation() {
    _controller.forward();
    _animation.addListener(() {
      setState(() {
        backgroundOpacity = 0.7 * _animation.value;
      });
    });
  }

  void stopAnimation() {
    _controller.stop();
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  void onCollapseTap() {
    if (isCollapsed) {
      Future.delayed(Duration(
        milliseconds: 70,
      )).then((value) {
        setState(() {
          isCollapsedAfterSec = !isCollapsedAfterSec;
        });
      });
    } else if (!isCollapsed) {
      setState(() {
        isCollapsedAfterSec = !isCollapsedAfterSec;
      });
    }
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(
        backgroundOpacity,
      ),
      body: Row(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (ctx, child) {
              return AnimatedContainer(
                duration: Duration(
                  milliseconds: 70,
                ),
                width: (isCollapsed) ? width * .2 * _animation.value : width * .5 * _animation.value,
                margin: EdgeInsets.only(
                  left: width * .06 * _animation.value,
                  top: height * .05,
                  bottom: height * .05,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff222232),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: (_animation.value > 0.7)
                    ? Column(
                        children: [
                          isCollapsed
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    "NB",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    "NITUSUE BET",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.home,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Mwanzo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.receipt,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Shindani',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.question,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Kuhusu',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),

                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Malipo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.xbox,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Request',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),

                          Spacer(),
                          Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.cog,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Mpangilio',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),
                          DrawerItem(
                            icon: Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.white,
                              size: 15,
                            ),
                            label: Text(
                              'Notification',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            isCollapsed: isCollapsedAfterSec,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DrawerUser(
                            afterCollapse: 'CG',
                            beforeCollapse: 'Costantino Gwaka',
                            isCollapsed: isCollapsed,
                          ),
                          // * Bottom Toggle Button
                          if (_controller.value >= 1)
                            DrawerCollapse(
                              isCollapsed: isCollapsed,
                              onTap: onCollapseTap,
                            ),
                        ],
                      )
                    : SizedBox(),
              );
            },
          ),

          // * The left area on the side which will used
          // * to close the drawer when tapped

          Expanded(
            flex: 3,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  reverseAnimation();
                  Future.delayed(
                    Duration(
                      milliseconds: 500,
                    ),
                  ).then(
                    (value) => widget.closeFunction(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
