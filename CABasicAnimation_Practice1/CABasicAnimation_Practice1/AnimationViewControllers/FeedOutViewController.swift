//
//  FeedOutViewController.swift
//  CABasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/12.
//

import UIKit

// 【疑問】@IBOutletとshapeLayerを組み合わせる方法はないのか？ それがPath？
class FeedOutViewController: UIViewController {

    @IBOutlet private weak var feedOutView: UIView!

    private let shapeLayer = CAShapeLayer()
    // 【疑問】このパスのクラスは他に種類はないのか？
    // 【回答】とりあえずこのUIBezierPathが基本っぽい
    private let path = UIBezierPath()
    private var height: CGFloat { feedOutView.frame.size.height }
    private var width: CGFloat { feedOutView.frame.size.width }

    // 【疑問】@IBOutletのViewを使うときは、pathを通す必要があるのか？？
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // 【疑問】具体的に何をしているのかわからない。。。
    // CAはUIBezierPathの描画アニメーションの際にも使える
    private func setupView() {
        path.move(to: CGPoint(x: width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: width, y: height / 2))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3
        feedOutView.layer.mask = shapeLayer
    }

    // MARK: - CABasicAnimation
    @IBAction func startFeedOut(_ sender: Any) {

        // 【疑問メモ】毎回キーを設定する？
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 4
        animation.isRemovedOnCompletion = false
//        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.fillMode = .forwards
        // 【疑問】これは何？
        // CAの遅延実行
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        // CAの遅延実行
        animation.beginTime = CACurrentMediaTime() + 2
        // CAの実行スピード // defaultsは1
        // 0にすると停止 // durationをspeedで割る
        animation.speed = 2
        shapeLayer.add(animation, forKey: nil)
    }

}
