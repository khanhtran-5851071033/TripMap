import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:example/view/shared/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget hotspotButton(MyHotspot hotspot, VoidCallback onTap, VoidCallback onShow,
    String content) {
  return Transform(
    transform: hotspot.type == HotspotType.arrow
        ? hotspot.name.trim() == '^'
            ? (Matrix4.identity()..rotateX(200))
            : (Matrix4.identity()..rotateX(150))
        : (Matrix4.identity()..rotateX(0)),
    child: AvatarGlow(
      glowColor: hotspot.type == HotspotType.arrow ? Colors.white : myColor,
      endRadius: hotspot.type == HotspotType.arrow
          ? hotspot.name.trim() == '^'
              ? 30
              : 70.0
          : 27,
      duration: Duration(seconds: 1),
      repeat: true,
      // showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 500),
      child: InkWell(
        child: hotspot.type == HotspotType.arrow
            ? Transform.scale(
                scale: hotspot.scale,
                child: Container(
                    padding: EdgeInsets.all(2),
                    width: hotspot.name.trim() == '^' ? 60 : 80,
                    height: hotspot.name.trim() == '^' ? 60 : 80,
                    decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('assets/node.png')),
                      // color: type == 'arrow'
                      //     ? Colors.amber.withOpacity(0.5)
                      //     : Color(0xff29166F),
                      shape: hotspot.type == HotspotType.arrow
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: Icon(
                              Icons.double_arrow,
                              color: Colors.black,
                              size: hotspot.name.trim() == '^' ? 18 : 24,
                            ),
                          ),
                          hotspot.name.trim() == '^'
                              ? Container()
                              : Text(
                                  hotspot.name,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    )),
              )
            : Transform.scale(
                scale: hotspot.scale,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff29166F),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 1)),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        hotspot.name.length > 10
                            ? Expanded(
                                child: Text(
                                  hotspot.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Text(
                                hotspot.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              )
                      ],
                    ),
                  ),
                ),
              ),
        onTap: () {
          hotspot.type == HotspotType.arrow ? onTap() : onShow();
        },
      ),
    ),
  );
}
