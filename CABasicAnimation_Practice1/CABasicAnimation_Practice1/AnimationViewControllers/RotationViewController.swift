//
//  RotationViewController.swift
//  CABasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/12.
//

// import TheAnimationを入れるべき
import UIKit


class RotationViewController: UIViewController {

    let layer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        layer.backgroundColor = UIColor.green.cgColor
        // 最初のview？layerの位置
        layer.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
        view.layer.addSublayer(layer)

        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.animateMovement()
            self.animateOpacity()
            self.rotate()
        })
    }

    private func rotate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
//        animation.toValue = 180 / 2 // めっちゃ早い笑笑
        animation.toValue = 22 // ちょっどいい速さ　// speedは1
        animation.duration = 4
//        animation.speed = 0.1　// toVaule 90 とかでもこれでちょっと遅くなった
        // 【疑問】具体的に何をしているのかわからない
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        // 【疑問】これは具体的に何？
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }

    private func animateMovement() {
        let animation = CABasicAnimation(keyPath: "position")
        // 【疑問】originと0の違いは？
//        animation.fromValue = CGPoint(x: layer.frame.origin.x, // 100
//                                      y: layer.frame.origin.y) // 150
        animation.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.size.width/2), // 100 + 100/2
                                      y: layer.frame.origin.y + (layer.frame.size.height/2)) // 150 + 100/2
        animation.toValue = CGPoint(x: 300, y: 500)
        animation.duration = 4
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }

    private func animateOpacity() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 4
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }

}
