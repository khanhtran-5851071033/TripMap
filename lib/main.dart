import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/floorplan_model.dart';
import 'view/screens/splash_screen.dart';
import 'view/shared/util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(
            create: (context) => FloorPlanModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UTC2',
        theme: ThemeData(fontFamily: 'Nunito', primaryColor: Util.myColor),
        home: SplashScreen(),
      ),
    );
  }
}
