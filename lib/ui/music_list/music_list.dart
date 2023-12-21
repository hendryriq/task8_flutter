import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_8/models/music_model.dart';
import 'package:task_8/provider/provider_music.dart';
import 'package:task_8/response/res_music.dart';
import 'package:task_8/ui/audio_player/player_page.dart';
import 'package:task_8/ui/music_list/music_item.dart';
import 'package:task_8/utils/nav_utils.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  int currentMusic = 0;

  final player = AudioPlayer();
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderMusic.init();
      },
      child: Consumer<ProviderMusic>(
        builder: (BuildContext context, valMus, Widget? child) => Scaffold(
          appBar: AppBar(
            title: const Text("My List"),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: valMus
                  .listMusic.length, // Set the number of items in your list
              itemBuilder: (BuildContext context, index) {
                currentMusic = index;
                ListMusic data = valMus.listMusic[index];
                print("coba${data.author}");
                if (!isOpened)
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentMusic = index;
                      isOpened = !isOpened;
                    });
                    NavUtils.goTo(
                        context,
                        PlayerPage(
                            index: index,
                            player: player,
                            data: ListMusic(
                                id: data.id,
                                cover: data.cover,
                                author: data.author,
                                name: data.name,
                                path: data.path),
                            onTap: () => currentMusic));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage("${data.cover}")),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.name}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${data.author}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isOpened ? MediaQuery.of(context).size.height : 100,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF845EC2),
              padding: const EdgeInsets.all(16),
              child: isOpened
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: PlayerPage(
                            onTap: () {
                              isOpened = !isOpened;
                              setState(() {});
                            },
                            index: currentMusic,
                            player: player,
                            data: valMus.listMusic[currentMusic]),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        isOpened = !isOpened;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        valMus.listMusic[currentMusic].cover))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                valMus.listMusic[currentMusic].name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                valMus.listMusic[currentMusic].author,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                            ],
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  player.state == PlayerState.playing
                                      ? player.pause()
                                      : player.play(AssetSource(
                                          musics[currentMusic % musics.length]
                                              .path));
                                  setState(() {});
                                },
                                icon: Icon(
                                  player.state == PlayerState.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}
