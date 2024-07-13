import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rmbetting/data/model/response_object.dart';
import 'package:rmbetting/data/network_services/network_service.dart';
import '../widgets/appbar.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  WaitingScreenState createState() => WaitingScreenState();
}

class WaitingScreenState extends State<WaitingScreen> {
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    loadData();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        timer.cancel();
        // Handle timer completion actions here
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  loadData() async {
    ResponseObject response = await NetworkCaller.getRequest(
        "https://t20betting.naz24h.com/api/game-check");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/waiting.json"),
          const Text(
            "Please Wait For Other Player",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          const SizedBox(height: 10),
          Text(
            '$_start seconds remaining',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
