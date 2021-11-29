/*

Author: Meng-Shan Lee

ToDo:
剖析 https://jsonplaceholder.typicode.com/albums，並定義Album類別，
設計toJson與fromJson方法，從外部系統取回一系列json array時，能夠轉換成List<Album>，
並取用第五個Album object 。 再將該Album object，轉換回json後，作為http的post方法內容送出
*/

import "dart:convert";

// 引入套件
import 'package:http/http.dart' as http;

class Album {

  // 設定此類別的組成要件
  int userId;
  int id;
  String title;
  
  // 設定此類別的核心建構子
  // 特殊語法格式，意思就是用戶到時候按序輸入四個對應型別的參數，即可獲得一個User 物件
  Album(this.userId,this.id,this.title);


  // factory 多重建構子:factory 類別名.方法名(參數型別 參數名){方法邏輯，必須回傳該類別的物件}
  // 類別的專屬方法，不需先生成物件，再由物件觸發，直接以類別就可調度的方法，但須回傳該類別的物件
  // 此方法為輸入一個json object後，從該object內提取出userId欄位、id欄位、title欄位、body欄位，組合成User物件
  factory Album.fromJson(dynamic userJson){

    int extractUserId = userJson["userId"];
    int extractId = userJson["id"];
    String extractTitle = userJson["title"];
    return Album(extractUserId,extractId,extractTitle);
  }
 

  // 增設一個toJson方法，可由物件轉換成可傳給外部系統的json
  // 此處為設定一個型別為Map<String, dynamic>的內容，並交由jsonEncode方法轉換成String，而後回傳。

  String toJson(){
    dynamic instanceMap ={"UserId":userId,"Id":id,"title":title,};
    return jsonEncode(
        instanceMap
    );
  }

}

// 此函數告知，未來會傳回一個 List<User>，函數名為getRemoteSystemUserData
Future<List<Album>> getRemoteSystemUserData() async {

  // 生成Uri物件
  Uri mutipleItemUrl = Uri.parse("https://jsonplaceholder.typicode.com/albums");

  // 使用http模組的get方法調度
  // 本應為Future<http.Response>，透過await，從Future取值後，型態宣告成http.Response
  http.Response remoteSystemResponses = await http.get(mutipleItemUrl);

  // 轉換成可操作的dart List
  List<dynamic> jsonArrayFromRemote = jsonDecode(remoteSystemResponses.body);

  // 將遠端傳回的dynamic json都轉成User物件
  List<Album> userArray =  jsonArrayFromRemote.map((dynamicUserJson)=>Album.fromJson(dynamicUserJson)).toList();
  
  // 將結果傳回
  return userArray;

}


void main()async{

  // 調度函數，向遠端取得一系列User物件
  List<Album> userArray = await getRemoteSystemUserData();
  // 嘗試調閱其中一個，並轉換成String，而後印出
  print(userArray[4].toJson());

  // 生成Uri物件
  Uri remoteSystemUrl = Uri.parse("https://jsonplaceholder.typicode.com/albums");
  // 將User物件轉換成json之後，傳回遠端系統
  // 本應為Future<http.Response>，透過await，從Future取值後，型態宣告成http.Response
  String postData = userArray[4].toJson();
  http.Response postResponses = await http.post(remoteSystemUrl,body:postData );
  // 將傳回結果印出
  print(postResponses.body);

}
