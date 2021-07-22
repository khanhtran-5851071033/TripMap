import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/shared/image_list.dart';
import 'package:example/view/shared/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget hotspotButton(MyHotspot hotspot, VoidCallback onTap) {
  return Transform(
    transform: hotspot.type == HotspotType.arrow
        ? (Matrix4.identity()..rotateX(150))
        : (Matrix4.identity()..rotateX(0)),
    child: AvatarGlow(
      glowColor: hotspot.type == HotspotType.arrow ? Colors.white : myColor,
      endRadius: hotspot.type == HotspotType.arrow ? 1000.0 : 27,
      duration: Duration(milliseconds: 300),
      repeat: true,
      // showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 500),
      child: InkWell(
        child: hotspot.type == HotspotType.arrow
            ? Container(
                padding: EdgeInsets.all(2),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/node.png')),
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
                        ),
                      ),
                      Text(
                        hotspot.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ))
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
                        Text(
                          hotspot.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        onTap: () {
          hotspot.type == HotspotType.arrow ? onTap() : print('abc');
        },
      ),
    ),
  );
}
