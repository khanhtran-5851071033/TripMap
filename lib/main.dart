import 'package:utc2/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/floorplan_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(
            create: (context) => FloorPlanModel()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UTC2',
        theme: ThemeData(
          fontFamily: 'Nunito',
          primaryColor: Color(0xff29166F),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
