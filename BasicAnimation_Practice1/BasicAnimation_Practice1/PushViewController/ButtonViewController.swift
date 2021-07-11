//
//  ButtonViewController.swift
//  BasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/11.
//

import UIKit

class ButtonViewController: UIViewController {

    @IBAction func bounce(_ sender: Any) {
        let theButton = sender as! UIButton
//        print(theButton.bounds) // (0.0, 0.0, 106.0, 30.0)
        // 初期状態
        let bounds = theButton.bounds

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10,
                       // 【疑問メモ】animationの引数は書くとエラーが出る
                       options: .curveEaseInOut, animations: {
            theButton.bounds = CGRect(x: bounds.origin.x - 20,
                                      y: bounds.origin.y,
                                      width: bounds.size.width + 60,
                                      height: bounds.size.height)
                        // 【疑問】sucessのフラグは本当にいるのか？
        }, completion: { (sucess: Bool) in
            if sucess {
                // パターン①　⭕　// すぐ、一瞬でやる
//                print(theButton.bounds) // (-20.0, 0.0, 106.0, 30.0)
//                theButton.bounds = bounds
//                print(theButton.bounds) // (0.0, 0.0, 106.0, 30.0)

                // パターン②　// 0.5かけてじっくりやる
//                UIView.animate(withDuration: 0.5, animations: {
//                    // 0.5秒かけてゆっくり戻る？？
//                    print(theButton.bounds) // (-20.0, 0.0, 106.0, 30.0)
//                    theButton.bounds = bounds
//                    print(theButton.bounds) // (0.0, 0.0, 106.0, 30.0)
//                })

                // パターン③ // 1.5秒後に一瞬でやる　⭕
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    // 変更したboundsを初期設定に戻す
                    print(theButton.bounds) // (-20.0, 0.0, 106.0, 30.0)
                    theButton.bounds = bounds
                    print(theButton.bounds) // (0.0, 0.0, 106.0, 30.0)
                })
            }
        })
    }
}
