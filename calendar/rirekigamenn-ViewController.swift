//
//  rirekigamenn-ViewController.swift
//  calendar
//
//  Created by Issei Fukumura on 2021/06/20.
//

import UIKit

class rirekigamenn_ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    //MARK: 今回の機能を実装するのに必要な変数を洗い出す

       // 履歴を一覧で表示するためにテーブルビューを宣言する
       @IBOutlet var tableView: UITableView!

       // 履歴のデータを保存しておく配列
       var historyArray: [[String: Any]] = []
       // データベース（UserDefaults）から履歴のデータを取り出すための変数
       var saveData: UserDefaults = UserDefaults.standard
       
       // MARK: 今回の機能で必要なメソッドを洗い出す
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // viewDidLoadで行いたいブロックを呼び出す
           
           getAllHistory()
           reloadTableView()
           
           // データーソースとデリゲートを設定する
           tableView.dataSource = self
           tableView.delegate = self
       }
       
       // テーブルビューをリロードするメソッド
       func reloadTableView() {
           tableView.reloadData()
       }

       // saveData変数から履歴のデータを取り出すメソッド
       func getAllHistory() {
           historyArray = saveData.object(forKey: "history") as! [[String: Any]]
       }
       
       // セル一つ一つに対して表示するデータを決定する
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           // セルを読み込む
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
           
           // 該当する履歴のデータを配列から取り出す
           cell.textLabel?.text = historyArray[indexPath.row]["kadai"] as? String
           
           return cell
       }

       // セルの個数を決定するメソッド
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // 配列の要素数と同じ数だけセルを表示するように設定する
           return historyArray.count
       }
   }






