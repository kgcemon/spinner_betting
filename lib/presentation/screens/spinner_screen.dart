import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';

import 'category_screen.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  final selected = BehaviorSubject<int>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<int> items = [
    200,
    200,
    200,
    200,
    200,
    200,
    200,
    900,
    300,
  ];
  final List<Color> colors = [
    const Color(0xFF4D00FC),
    const Color(0xFF3B0972),
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyanAccent,
  ];

  String rewards = '';
  int spin1time = 0;
  final int predefinedWinnerIndex = 0;

  @override
  void dispose() {
    selected.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (spin1time == 0) {
        spin1time = 2;
        _playSound();
        selected.add(predefinedWinnerIndex);
      }
    });
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('sound/sound.mp3'));
  }

  void _playWinnerSound() async {
    await _audioPlayer.play(AssetSource('sound/winner.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/woman.png"),fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              SizedBox(
                height: 300,
                child: FortuneWheel(
                  physics: CircularPanPhysics(),
                  duration: const Duration(seconds: 13),
                  selected: selected.stream,
                  animateFirst: false,
                  onAnimationEnd: () {
                    setState(() {
                      rewards = items[selected.value].toString();
                      _showResultDialog();
                    });
                  },
                  items: [
                    for (int i = 0; i < items.length; i++)
                      FortuneItem(
                        style: FortuneItemStyle(
                          color: colors[i % colors.length],
                          borderColor: Colors.black,
                          borderWidth:
                          2.0,
                        ),
                        child: Text(items[i].toString()),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog() {
    _playWinnerSound();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/lottie/winner.json",
                height: 200,
                reverse: false,
              ),
              const Text(
                'Congratulations! You won',
                style: TextStyle(
                  backgroundColor: Colors.white,
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              FutureBuilder(
                future: Future.delayed(const Duration(seconds: 3)),
                builder: (context, snapshot) => ElevatedButton(
                    onPressed: () => Get.offAll(() => const CategoryScreen()),
                    child: const Text("Ok")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
