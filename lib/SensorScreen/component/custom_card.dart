import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homeiotapplicationdesign/constants.dart';

class CustomCard extends StatefulWidget {
  final Icon icon;
  final Size size;
  final String title, statusOn, statusOf;

  const CustomCard(
      {Key key, this.icon, this.size, this.title, this.statusOn, this.statusOf})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool isChecked = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _animation = Tween<Alignment>(
            begin: Alignment.bottomCenter, end: Alignment.topCenter)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.easeInBack,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: widget.size.width * 0.35,
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 0,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.icon,
                widget.title != "LEAKS"
                    ? AnimatedBuilder(
                        animation: _animationController,
                        builder: (animation, child) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_animationController.isCompleted) {
                                  _animationController.animateTo(20);
                                } else {
                                  _animationController.animateTo(0);
                                }
                                isChecked = !isChecked;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade50,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 8,
                                    offset: Offset(3, 3),
                                  ),
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(-3, -3),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: _animation.value,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 1),
                                  decoration: BoxDecoration(
                                    color: isChecked
                                        ? kGreenColor
                                        : Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kBlueColor,
              ),
            ),
            Text(
              isChecked ? widget.statusOn: widget.statusOf  ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isChecked ? kGreenColor : Colors.grey.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
