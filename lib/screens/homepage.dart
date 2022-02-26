import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _loadingController;
  bool isGreenCoffee = false;
  bool isTextReady = false;

  @override
  void initState() {
    _loadingController = AnimationController(vsync: this);
    _loadingController.addListener(() {
      if (_loadingController.value > 0.9) {
        _loadingController.stop();
        isGreenCoffee = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          isTextReady = true;
          setState(() {});
        });
      } else {}
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _loadingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 208, 181),
      body: Stack(
        children: [
          Visibility(
            visible: isGreenCoffee,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create your own unique\nblend of coffee to your taste',
                      style: GoogleFonts.patrickHand(
                          textStyle: const TextStyle(
                              fontSize: 18.0, color: Color(0xff674335), fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 58, 41, 34),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: isGreenCoffee ? (height / 1.2) : height,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: Colors.black26,
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(isGreenCoffee ? 25.0 : 0),
                  bottomRight: Radius.circular(isGreenCoffee ? 25.0 : 0),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedCrossFade(
                  firstChild: Center(child: Lottie.asset('assets/lottie/coffee.json')),
                  secondChild: Center(
                    child: Lottie.asset('assets/lottie/loading.json',
                        controller: _loadingController, height: height / 2, onLoaded: (composition) {
                      _loadingController.duration = composition.duration;
                      _loadingController.forward();
                    }),
                  ),
                  crossFadeState: isGreenCoffee ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(seconds: 1),
                  firstCurve: Curves.easeOut,
                  secondCurve: Curves.easeIn,
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: isTextReady ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      'Coffee cups',
                      style: GoogleFonts.lobster(
                          textStyle: const TextStyle(
                        fontSize: 38.0,
                        color: Color(0xff674335),
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
