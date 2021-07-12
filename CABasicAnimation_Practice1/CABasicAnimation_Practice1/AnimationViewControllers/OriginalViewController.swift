//
//  OriginalViewController.swift
//  CABasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/12.
//

import UIKit

class OriginalViewController: UIViewController {

    private let shapeLayer = CAShapeLayer()
    private let height: CGFloat = 100
    private let width: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shapeLayer.backgroundColor = UIColor.blue.cgColor
        shapeLayer.cornerRadius = 20
        shapeLayer.frame = CGRect(x: view.center.x - (width/2), y: 200,
                                  width: width, height: height)
        view.layer.addSublayer(shapeLayer)

    }

    // MARK: - CABasicAnimation
    @IBAction func startFeedOut(_ sender: Any) {

        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
//        animation.beginTime = 1
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.duration = 1
        // 単位はラジアン？ // 30とかにすると何周するの〜笑笑
        animation.fromValue = 0.1
        animation.toValue = -0.1
        animation.speed = 5
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        // 何回でも続ける
        animation.repeatCount = Float.infinity
        // 戻ってくる
        animation.autoreverses = true
        self.shapeLayer.add(animation, forKey: nil)
    }

}
