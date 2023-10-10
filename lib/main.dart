import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/cubit/observer/bloc_observer.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_cubit.dart';
import 'package:messanger_app/screens/login_screen/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PickerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[400],
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.grey.shade400, elevation: .7),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.grey.shade400,
          ),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
