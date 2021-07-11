//
//  ViewController.swift
//  BasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/10.
//

import UIKit

class TitleViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!

    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelRightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var bodyTextViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bodyTextViewRightConstraint: NSLayoutConstraint!

    // ライフサイクルで一番最初に呼ばれるところ
    override func loadView() {
        super.loadView()
        // constantに代入なので、textViewの方が位置的には上にある
        // heightを設定していないけど、適当に250
        titleLabelTopConstraint.constant -= 250
        titleLabel.alpha = 0
        bodyTextViewTopConstraint.constant -= 300
        bodyTextView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }

    private func showAnimation() {
        // 【メモ】animaitonつけない場合のコード
//        self.titleLabelTopConstraint.constant += 250
//        self.titleLabel.alpha = 1
//        self.bodyTextViewTopConstraint.constant += 300
//        self.bodyTextView.alpha = 1


        // viewが出来上がった後に位置的には1秒だけ間を開けてからanimation開始
        // executeはトレイニングクロージャ
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // animationをつける
            // animatespriと打ついい感じの設定になっている
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: []) {
                // animationのところにトレイニングクロージャとして処理を入れる
                self.titleLabelTopConstraint.constant += 250
                self.titleLabel.alpha = 1
                // 上からスライドさせるところまで表示させたいなら必要
                // 【疑問】実際には何をしているのか
                self.view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: []) {
                    self.bodyTextViewTopConstraint.constant += 350
                    self.bodyTextView.alpha = 1
                } completion: { _ in
                    self.dismissAnimation()
                }
            }
        }
    }

    private func dismissAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: []) {
                // 右にスライドしながら消えていく
//                self.titleLabelRightConstraint.constant -= 400
//                self.titleLabel.alpha = 0
//                self.view.layoutIfNeeded()


                self.titleLabel.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: []) {
                    // これを入れると動きが悪くなる！？
//                    self.bodyTextViewRightConstraint.constant -= 400
                    // その場でフェードアウトしていくanimaiton
//                    self.bodyTextView.alpha = 0


                    self.bodyTextViewRightConstraint.constant -= 400
                    self.bodyTextView.alpha = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

}
