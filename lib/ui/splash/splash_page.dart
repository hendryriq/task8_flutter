import 'package:flutter/material.dart';
import 'package:task_8/ui/audio_player/player_page.dart';
import 'package:task_8/ui/music_list/music_list.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  toNextPage() {
    Future.delayed(Duration(seconds: 3)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => MusicListPage()),
            (route)=> false));
  }

  @override
  void initState() {
    toNextPage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF845EC2),
        child: Center(
          child: Text(
            "Task 8\nMusic Player",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
