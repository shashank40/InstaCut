import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:InstaCut/providers/user_provider.dart';
import 'package:InstaCut/responsive/mobile_screen_layout.dart';
import 'package:InstaCut/responsive/responsive_layout.dart';
import 'package:InstaCut/responsive/web_screen_layout.dart';
import 'package:InstaCut/screens/login_screen.dart';
import 'package:InstaCut/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //////// To esure widegts initalized before firebase comes.
  ///
  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      ///// web app open to use ye
      options: const FirebaseOptions(
          apiKey: "AIzaSyCzM-MbCFadl1QcAOQp8VlL198PgBwwG1U",
          appId: "1:236927062295:web:2317be7c3f7dbd814b2752",
          messagingSenderId: "236927062295",
          projectId: "instacut-7cd04",
          storageBucket: "instacut-7cd04.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();

    /// else initialize for phone app
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InstaCut',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder( //// To check if there is a persisting user already
        ///dont go to login page, else go to login by checking from firebase
        /// that authenttication ka kya state hei
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet so wait
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

              /// snapshot has no data means we need to login
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
