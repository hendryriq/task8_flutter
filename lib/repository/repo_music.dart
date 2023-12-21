import 'package:flutter/foundation.dart';
import 'package:task_8/api/api.dart';
import 'package:dio/dio.dart';
import 'package:task_8/response/res_music.dart';

class RepoMusic{
  Future<ResMusic?> getMusic() async{
    try{
      print("repo print");
      Response res = await Api().dio.get("${Api.baseUrl}getMusic.php");
      return resMusicFromJson(res.data);
    }catch (e, st) {
      if (kDebugMode) {
        print("Error e ${e.toString()}");
        print("Error st ${st.toString()}");
      }
    }
  }
}