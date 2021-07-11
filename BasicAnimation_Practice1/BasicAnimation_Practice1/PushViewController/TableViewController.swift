//
//  TableViewController.swift
//  BasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/11.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sampleModel = [
        "東京","東京","東京","東京","東京","東京","東京","東京","東京","東京",
        "東京","東京","東京","東京","東京","東京","東京","東京","東京","東京",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        animateTable() // ここでは動かない！！
        tableView.dataSource = self
        tableView.delegate = self
        // ここなら上手くいく！！！！！！！！
        animateTable()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ここだと最初ができていない
//        animateTable()
    }

    // ①恐らく最初に上から下向きで流れるcellをセットする
    // ②0.05秒ずつ遅れて元の位置に戻すとあら不思議、下から上に向かっていくように見える！！
    func animateTable() {
        tableView.reloadData()
        // このプロパティの値は、UITableViewCellオブジェクトを含む配列で、それぞれがテーブルビューの可視セルを表す
        let cells = tableView.visibleCells
//        print(tableView.bounds.size.height) // 744
        let tableViewHeight = tableView.bounds.size.height

        for cell in cells {
            // 与えられた翻訳値から構築されたアフィン変換行列を返す
            // 座標系のX軸を移動させるための値 // 座標系の Y 軸を移動させるための値
            // オブジェクトが描かれている場所を移動させたいだけの場合は、アフィン変換を構築する必要はありません。
            // 描画を移動させる最も直接的な方法は、関数translateBy(x:y:)を呼び出すことです。
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }

        // 【疑問メモ】以下がないとアニメーションが動かない　// 当たり前だけど、animationを設定していないだろ！
        var delayCounter: Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                            // The identity transform.
                            // これだけだと、何も動かない
                cell.transform = CGAffineTransform.identity

                // これだけだと、上から下に流れてくる
//                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            }, completion: nil)
            delayCounter += 1
        }
    }
}

extension TableViewController: UITableViewDelegate {

}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sampleModel[indexPath.row] + "\(indexPath.row)"
        return cell
    }


}
