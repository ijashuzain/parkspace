import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/providers/area_provider.dart';
import 'package:parkspace/providers/auth_provider.dart';
import 'package:parkspace/providers/booking_provider.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/starter.dart';
import 'package:parkspace/utils/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'providers/home_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Sizer(
      builder: (context, orientation,deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => BookingProvider()),
            ChangeNotifierProvider(create: (_) => AreaProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ParkSpace',
            routes: routes,
            initialRoute: StarterPage.routeName,
          ),
        );
      }
    );
  }
}
