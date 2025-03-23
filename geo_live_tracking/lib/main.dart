import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_live_tracking/buisness_logic/gmaps/g_maps_cubit.dart';
import 'package:geo_live_tracking/firebase_options.dart';
import 'package:geo_live_tracking/presentation/home.dart';
import 'package:geo_live_tracking/presentation/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live tracking',
      // theme: ThemeData(
      //   primaryColor: Colors.white
      // ),
      // home: BlocProvider(
      //   create: (context) => GMapsCubit(),
      //   child: HomeScreen(),
      // ),
      home: GetStartedPage(),

    );
  }
}
