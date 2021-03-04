import 'package:example/core/models/models.dart';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //crossAxisSpacing: 2.0,
        //mainAxisSpacing: 2.0,
        crossAxisCount: 3,
      ),
      itemCount: 9,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int currentTile = index + 1;
        List<Light> tileLights =
            model.lights.where((item) => item.tile == currentTile).toList();

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
            ),
            Stack(
              children: List.generate(
                tileLights.length,
                (idx) {
                  return Transform.translate(
                    offset: Offset(
                      size.width * tileLights[idx].position[0],
                      size.width * tileLights[idx].position[1],
                    ),
                    child: RotatedBox(
                      quarterTurns: tileLights[idx].status ? 0 : 3,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: !model.isScaled
                            ? <Widget>[
                                Container(
                                  width: 15,
                                  child: RotatedBox(
                                    quarterTurns:
                                        tileLights[idx].status ? 0 : 1,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.room,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(17.0),
                                  child: Stack(
                                    children: [
                                      Text(
                                        tileLights[idx].name,
                                        style: TextStyle(
                                          fontSize: 9,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 0.7
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      Text(
                                        tileLights[idx].name,
                                        style: TextStyle(
                                          fontSize: 9.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]
                            : <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: RotatedBox(
                                    quarterTurns:
                                        tileLights[idx].status ? 0 : 1,
                                    child: Image.asset(
                                      'assets/image.png',
                                      width: 10 * model.scale / 1.5,
                                      height: 10 * model.scale / 1.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(10 * model.scale / 1.4),
                                  child: Stack(
                                    children: [
                                      Text(
                                        tileLights[idx].name,
                                        style: TextStyle(
                                          fontSize: 6,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 0.5
                                            ..color = Colors.black,
                                        ),
                                      ),
                                      Text(
                                        tileLights[idx].name,
                                        style: TextStyle(
                                          fontSize: 6.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                      ),
                    ),
                  );
                },
              ),
            )
            // : CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Text(
            //       '${tileLights.length}',
            //       style: TextStyle(
            //         color: Global.blue,
            //       ),
            //     ),
            // ),
          ],
        );
      },
    );
  }
}
