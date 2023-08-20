import 'package:counter_app_bloc/counter/bloc.dart';
import 'package:counter_app_bloc/notif_helper.dart';
import 'package:counter_app_bloc/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///initialize firebase
  await Firebase.initializeApp();

  //initialize notifications
  NotifHelper.initNotif();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  const String key = String.fromEnvironment('SECRET_KEY');
  print(key);

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
