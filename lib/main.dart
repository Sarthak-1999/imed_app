import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imed_app/components/user_state.dart';
import 'package:imed_app/screens/ams_screen1.dart';
import 'package:imed_app/screens/ams_screen2.dart';
import 'package:imed_app/screens/bookmarks_screen.dart';
import 'package:imed_app/screens/classroom_screen1.dart';
import 'package:imed_app/screens/classroom_screen2.dart';
import 'package:imed_app/screens/create_post.dart';
import 'package:imed_app/screens/explore_screen.dart';
import 'package:imed_app/screens/forgotPass_screen.dart';
import 'package:imed_app/screens/help_screen.dart';
import 'package:imed_app/screens/home_screen.dart';
import 'package:imed_app/screens/login_screen.dart';
import 'package:imed_app/screens/profile_user.dart';
import 'package:imed_app/screens/programming_screen.dart';
import 'package:imed_app/screens/registration_screen.dart';
import 'package:imed_app/screens/studyWithMe_screen.dart';
import 'package:imed_app/screens/userDetails_screen.dart';
import 'package:imed_app/screens/view_profile.dart';
import 'package:imed_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'components/navigation_provider.dart';
import 'components/theme_provider.dart';

void main() {
  runApp(const Imed());
}

class Imed extends StatelessWidget {
  const Imed({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorLog();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => NavigationProvider(),
            child: MaterialApp(
              themeMode: ThemeMode.system,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: 'user_state',
              routes: {
                'user_state': (context) => UserState(),
                'welcome_screen': (context) => const WelcomeScreen(),
                'login_screen': (context) => const LoginScreen(),
                'registration_screen': (context) => const RegistrationScreen(),
                'forgotPass_screen': (context) => const ForgotPassScreen(),
                'userDetails_screen': (context) => const UserDetailsScreen(),
                'home_screen': (context) => const HomeScreen(),
                'create_post': (context) => CreatePost(),
                'profile_page': (context) => ProfilePage(),
                'bookmarks_screen': (context) => BookmarksScreen(),
                'help_screen': (context) => HelpScreen(),
                'ams1_screen': (context) => const AmsScreen1(),
                'ams2_screen': (context) => const AmsScreen2(),
                'classroom_screen1': (context) => const ClassroomScreen1(),
                'classroom_screen2': (context) => const ClassroomScreen2(),
                'explore_screen': (context) => ExploreScreen(),
                'youtubeLinksPlayer_screen': (context) => YoutubeLinksPlayer(),
                'studyWithMe_screen': (context) => StudyWithMe(),
                //'view_profile': (context) => const ViewProfile(),
              },
            ),
          );
        } else {
          return const ErrorLog();
        }
      },
    );
  }
}

class ErrorLog extends StatelessWidget {
  const ErrorLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: const [
              Text('Umhmm! You seem to be offline'),
              Text('Please try checking your Internet connection '),
            ],
          ),
        ),
      ),
    );
  }
}
