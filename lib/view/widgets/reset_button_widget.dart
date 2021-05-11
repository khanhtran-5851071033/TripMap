
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/floorplan_model.dart';
import '../shared/global.dart';

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
