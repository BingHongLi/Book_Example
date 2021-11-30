/*

Author: Meng-Shan Lee
https://www.linkedin.com/in/meng-shan-lee-188035227/

ToDo:
設計一個主程序，會印出會議開始，
中間過程透過Future.delayed印出請老何訂購餐點，
最後在主程序印出會議結束


*/

void main() {
  
  // 印出會議開始
  print("會議開始");
  
  // 請老何訂購餐點，稍後執行
  Future.delayed(
      Duration(seconds: 1),
      (){print("請老何訂購餐點");}
  );
  
  // 會議結束
  print("會議結束");
}

