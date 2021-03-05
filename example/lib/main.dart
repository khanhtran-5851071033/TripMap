import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/screens/home_route.dart';
import 'package:example/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: 'UTC2',
        // theme: ThemeData.dark(),
        home: SplashScreen(),
      ),
    );
  }
}
