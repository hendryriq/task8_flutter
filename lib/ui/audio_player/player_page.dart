import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_8/models/music_model.dart';
import 'package:task_8/response/res_music.dart';
import 'package:task_8/ui/music_list/music_list.dart';
import 'package:task_8/utils/nav_utils.dart';

class PlayerPage extends StatefulWidget {
  // MusicModel music;
  // ListMusic music;
  ListMusic? data;
  AudioPlayer player;
  int index;
  VoidCallback onTap;
  PlayerPage(
      {required this.data,
        required this.index,
      required this.player,
      required this.onTap,
      super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  Duration maxDuration = const Duration(seconds: 0);
  late ValueListenable<Duration> progress;

  @override
  void initState() {
    // TODO: implement initState
    widget.player.play(AssetSource("${widget.data?.path}"));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMaxDuration() {
      widget.player.getDuration().then((value) {
        maxDuration = value ?? const Duration(seconds: 0);
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:
          widget.onTap,
          // () {
          //   Navigator.pop(context);
          // },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Color(0xFF845EC2),
        title: Text(
          "Audio Player",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        color: Color(0xFF845EC2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${widget.data?.cover}"),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height: 60),
            Text("${widget.data?.name}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
            Text("${widget.data?.author}",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: widget.player.onPositionChanged,
                builder: (context, snapshot) {
                  return ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    total: maxDuration,
                    onSeek: (duration) {
                      widget.player.seek(duration);
                      setState(() {});
                    },
                  );
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      widget.player.stop();
                      widget.player.play(AssetSource(
                          "${widget.data?.path}"));
                      getMaxDuration();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 36,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      widget.player.state == PlayerState.playing
                          ? widget.player.pause()
                          : widget.player.play(AssetSource(
                          "${widget.data?.path}"));
                      getMaxDuration();
                      setState(() {});
                    },
                    icon: Icon(
                      widget.player.state == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      widget.player.stop();
                      widget.player.play(AssetSource(
                          "${widget.data?.path}"));
                      getMaxDuration();

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      size: 36,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
