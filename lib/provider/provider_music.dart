import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:task_8/repository/repo_music.dart';
import 'package:task_8/response/res_music.dart';

class ProviderMusic extends ChangeNotifier{
  ProviderMusic();

  ProviderMusic.init(){
    getMusic();
  }

  List<ListMusic> listMusic =[];

  bool isMusic = false;
  RepoMusic repo = RepoMusic();

  Future<void> getMusic() async{
    try{
      isMusic =true;
      notifyListeners();

      ResMusic? res = await repo.getMusic();

      print("bebas");
      if(res?.isSuccess == true){

        debugPrint("${res?.data}");
        isMusic = false;
        listMusic = res?.data ?? [];
        notifyListeners();
      }else{
        isMusic = false;
        if (kDebugMode){
          print("Error ${res?.isSuccess}");
        }
        notifyListeners();
      }
    }catch (e){
      isMusic = false;
      if(kDebugMode){
        print("Error e ${e.toString()}");
      }
      notifyListeners();
    }



  }
}

