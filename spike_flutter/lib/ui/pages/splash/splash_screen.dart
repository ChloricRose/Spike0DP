import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spike_test/ui/pages/primary/primary_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToOTherPage();
  }

  void moveToOTherPage() {
    /* Wait 2 seconds and move to other page */
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const PrimaryScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SvgPicture.asset("assets/svgs/splash.svg"),
        ),
      ),
    );
  }
}
