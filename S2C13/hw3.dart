/*

Author: Meng-Shan Lee
https://www.linkedin.com/in/meng-shan-lee-188035227/

ToDo:
建立一個Human類別，
裏面有字串型別的variety (品種屬性)， 數字型別的weight（重量屬性），
一個echo函數，使用時會印出 雲育鏈

*/

class Human {

  // 設定此類別的組成要件
  String variety;
  double weight;

  // 設定此類別的核心建構子
  // 特殊語法格式，意思就是用戶到時候按序輸入對應型別的參數，即可獲得一個Human物件
  Human(this.variety, this.weight);

  // 一個echo函數，使用時會印出 雲育鏈 
  void echo() {
    print("雲育鏈");
  }
}

//  調度class
void main() {
  Human CaptainAmerica = Human('American', 88);
  print(CaptainAmerica.variety);
  print(CaptainAmerica.weight);
  CaptainAmerica.echo();
}