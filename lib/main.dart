import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//my app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//homepage
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  //jump function
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  //start game
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {

      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;

      });

      setState(() {
        if(barrierXone<-2){
          barrierXone+=3.5;
        }else{
          barrierXone-=0.05;
        }
      });

      setState(() {
        if(barrierXtwo<-2){
          barrierXtwo+=3.5;
        }else{
          barrierXtwo-=0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            //Expan Blue
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    child: MyBird(),
                  ),

                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(
                      milliseconds: 0,
                    ),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(
                      milliseconds: 0,
                    ),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(
                      milliseconds: 0,
                    ),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(
                      milliseconds: 0,
                    ),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text('')
                        : Text(
                      'TAP TO PLAY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
            ),
            //Expan brown
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade700,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //score
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),

                    //best
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Best',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//bird.dart
class MyBird extends StatelessWidget {
  const MyBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/bird.png',
      height: 60,
      width: 60,
    );
  }
}

//MyBarrier
class MyBarrier extends StatelessWidget {
  const MyBarrier({Key? key, this.size}) : super(key: key);
  final size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        border: Border.all(width: 10,color: Colors.green),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
