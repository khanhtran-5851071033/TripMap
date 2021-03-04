import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    return RaisedButton(
      elevation: 10.0,
      color: Global.blue,
      onPressed: () {
        model.reset();
      },
      child: Icon(
        Icons.refresh,
        color: Colors.white,
      ),
    );
  }
}
