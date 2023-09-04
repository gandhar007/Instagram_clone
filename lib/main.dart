import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBms7yBsTKX-Acpzx9x2ecyo1o6-LVPqr0',
          appId: '1:261584596333:web:d62fb981d0a4999fae3e64',
          messagingSenderId: '261584596333',
          projectId: 'insatgram-clone-18e91',
          storageBucket: 'insatgram-clone-18e91.appspot.com'
      )
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor
        ),
        //home: const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout(),)
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout()
                );
              } else if(snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            // If user has no data the he will get returned to login screen
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

