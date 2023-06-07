import 'package:abc_pos/source/home/bloc/menu_bloc.dart';
import 'package:abc_pos/source/main/ui/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MenuBloc())],
      child: MaterialApp(
        title: "Antigua's Bake & Cuisine POS",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const MainPage(),
        home: const MainPage(),
      ),
    );
  }
}
