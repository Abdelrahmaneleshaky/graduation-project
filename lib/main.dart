import 'package:akarna/home.dart';
import 'package:akarna/portofolio.dart';
import 'package:akarna/splash_screen.dart';
import 'package:akarna/wallet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:akarna/account.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Akarna',
        theme: ThemeData(


          useMaterial3: true,
        ),
        home:SplashScreen()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.email,required this.status});
  final String email;
  final String title;
  final String status;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
     List<Widget> _widgetOptions = <Widget>[
       Homepage(email: widget.email,status:widget.status,),
       Portofolio(email: widget.email,status: widget.status,),
       Wallet(email: widget.email),
       const account_page(),
    ];

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green,
        indicatorColor: Colors.black,

        selectedIndex: _selectedIndex,


        onDestinationSelected: _onItemTapped, destinations:const [
          NavigationDestination(icon: Icon(Icons.home_outlined,color: Colors.white,) , label:'Home'),
        NavigationDestination(icon: Icon(Icons.pie_chart_outline,color: Colors.white,) ,label:'Porfolio',),
        NavigationDestination(icon: Icon(Icons.wallet,color: Colors.white,) , label:'Wallet'),
        NavigationDestination(icon: Icon(Icons.person,color: Colors.white,) , label:'Account'),
      ],
      ),
    );
  }
}
