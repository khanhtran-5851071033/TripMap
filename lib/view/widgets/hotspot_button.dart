import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget hotspotButton(MyHotspot hotspot, VoidCallback onTap) {
  return Transform(
    transform: hotspot.type == HotspotType.arrow
        ? (Matrix4.identity()..rotateX(150))
        : (Matrix4.identity()..rotateX(0)),
    child: AvatarGlow(
      glowColor: hotspot.type == HotspotType.arrow
          ? Colors.amber.withOpacity(0.8)
          : Color(0xff29166F),
      endRadius: 50.0,
      duration: Duration(milliseconds: 1500),
      repeat: true,
      // showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: InkWell(
        child: hotspot.type == HotspotType.arrow
            ? Container(
                padding: EdgeInsets.all(2),
                width: 80,
                height: 70,
                decoration: BoxDecoration(
                  color: hotspot.type == HotspotType.arrow
                      ? Colors.amber.withOpacity(0.5)
                      : Color(0xff29166F),
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        hotspot.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ))
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 100,
                  color: Color(0xff29166F),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hotspot.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Image.asset(
                        'assets/utc.png',
                        fit: BoxFit.fitWidth,
                        // height: 100,
                      ),
                    ],
                  ),
                ),
              ),
        onTap: () {
          onTap();
        },
      ),
    ),
  );
}
