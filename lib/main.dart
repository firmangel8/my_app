import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/components/auth_wrapper.dart';
import 'package:my_app/cubit/auth/auth_cubit.dart';
import 'package:my_app/cubit/balance/balance_cubit.dart';
import 'package:my_app/cubit/counter_cubit.dart';

import 'package:my_app/screens/news_screen.dart';
import 'package:my_app/screens/routes/BalanceScreen/balance_screen.dart';
import 'package:my_app/screens/routes/BooksScreen/books_screen.dart';

import 'package:my_app/screens/routes/CounterScreen/counter_screen.dart';
import 'package:my_app/screens/routes/DatasScreen/datas_screen.dart';
import 'package:my_app/screens/routes/FormScreen/form_screen.dart';
import 'package:my_app/screens/routes/LoginScreen/login_screen.dart';
import 'package:my_app/screens/routes/SecondScreen/custom_screen.dart';
import 'package:my_app/screens/routes/SecondScreen/second_screen.dart';
import 'package:my_app/screens/routes/SpendingScreen/spending_screen.dart';
import 'package:my_app/screens/routes/WelcomeScreen/welcome_screen.dart';
import 'package:my_app/screens/setting_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This function is called when the app is in background or terminated
  _showNotification(message);
  debugPrint("Handling a background message: ${message.notification?.title}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // _requestLocalNotifPermision();

  // const AndroidInitializationSettings androidInitializationSettings =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: androidInitializationSettings);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // // Request permission to receive notifications (Android only)
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   NotificationSettings? settings = await messaging.requestPermission();
  //   debugPrint("${settings.authorizationStatus}");
  // }

  // // Listen to incoming messages in the foreground
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   debugPrint(
  //       "Received message in foreground: ${message.notification?.title}");
  //   // Use this data to display a notification or take other actions
  //   _showNotification(message);
  //   debugPrint("show notification here");
  // });

  // // Listen to incoming messages when the app is in background or terminated
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   debugPrint(
  //       "Received message when app was closed: ${message.notification?.title}");
  //   // Handle notification tap event (optional)
  // });

  // // Get the registration token for this device
  // String? token = await messaging.getToken();
  // debugPrint("Registration token: $token");
  runApp(const MyApp());
}

Future<void> _requestLocalNotifPermision() async {
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidImplementation?.requestNotificationsPermission();
}

void _showNotification(RemoteMessage message) {
  // Customize notification based on your needs
  RemoteNotification? notification = message.notification;
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('my_app_id', 'my_app_name',
          channelDescription: 'Only for demonstrate notification',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  if (notification != null) {
    flutterLocalNotificationsPlugin.show(notification.hashCode,
        notification.title, notification.body, notificationDetails);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
          BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
          BlocProvider<AuthCubit>(create: (context) => AuthCubit())
        ],
        child: MaterialApp(
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(title: 'Home Screen'),
            '/login-screen': (context) => const LoginScreen(),
            '/balance-screen': (context) => const BalanceScreen(),
            '/spending-screen': (context) => const SpendingScreen(),
            // '/balance-screen': (context) =>
            //     const AuthWrapper(child: BalanceScreen()),
            // '/spending-screen': (context) =>
            //     const AuthWrapper(child: SpendingScreen()),
            '/second-screen': (context) => const SecondScreen(),
            '/custom-screen': (context) => const CustomScreen(),
            '/news-screen': (context) => const NewsScreen(),
            '/books-screen': (context) => const BooksScreen(),
            '/form-screen': (context) => const FormScreen(),
            '/datas-screen': (context) => const DatasScreen(),
            '/counter-screen': (context) => const CounterScreen(),
            '/welcome-screen': (context) => const WelcomeScreen(),
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BalanceScreen(),
    const SettingScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Settings',
    'Profile',
  ]; // List of titles corresponding to each screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateAndCloseDrawer(BuildContext context, String routeName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context); // Close the drawer first
    }
    Navigator.pushNamed(context, routeName);
  }

  Future<void> doLogout(context) async {
    debugPrint("need logout");
    final response = await DataService.logoutData();
    if (response.statusCode == 200) {
      await SecureStorageUtil.storage.delete(key: tokenStoreName);
      Navigator.pushReplacementNamed(context, "/login-screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 ? null : Text(_appBarTitles[_selectedIndex]),
        backgroundColor:
            _selectedIndex == 0 ? Colors.blue.shade900 : Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            listTilePush(context, 'News Screen', '/news-screen'),
            listTilePush(context, 'Datas Screen', '/datas-screen'),
            listTilePush(context, 'Counter Screen', '/counter-screen'),
            listTilePush(context, 'Balance Screen', '/balance-screen'),
            listTilePush(context, 'Spending Screen', '/spending-screen'),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                doLogout(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  ListTile listTilePush(
      BuildContext context, String screenName, String routesname) {
    return ListTile(
      title: Text(screenName),
      selected: _selectedIndex == 2,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routesname);
      },
    );
  }
}
