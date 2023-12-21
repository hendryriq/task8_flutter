import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_8/provider/provider_music.dart';
import 'package:task_8/response/res_music.dart';

class MusicItem extends StatefulWidget {
  const MusicItem({Key? key}) : super(key: key);


  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context){
        return ProviderMusic.init();
      },
      child: Consumer<ProviderMusic>(
        builder: (BuildContext context, valMus, Widget? child) =>
        ListView.builder(
          itemCount: valMus.listMusic.length, // Set the number of items in your list
          itemBuilder: (BuildContext context, index) {
            ListMusic data = valMus.listMusic[index];
            print("coba${data.author}");
            return Container(
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
            );
          },
        ),
      ),
    );
  }
}
