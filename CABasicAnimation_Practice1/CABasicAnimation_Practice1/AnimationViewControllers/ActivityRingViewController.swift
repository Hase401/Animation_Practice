//
//  ActivityRingViewController.swift
//  CABasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/12.
//

import UIKit

class ActivityRingViewController: UIViewController {

    private let shape = CAShapeLayer()
    private let trackShape = CAShapeLayer()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Goal"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // label.sizeToFit()がないと表示すらされない！！
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center


        // .piは180度
        let circlePath = UIBezierPath(arcCenter: view.center,
                                      // radiusは大きさ
                                      radius: 150,
                                      startAngle: -(.pi/2),
                                      endAngle: .pi*2,
                                      // clockwiseは時計回りならtrue
                                      clockwise: true)

        trackShape.path = circlePath.cgPath
        // 【疑問】ここでは、cgColorを使う!?
        trackShape.strokeColor = UIColor.lightGray.cgColor
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 22
        view.layer.addSublayer(trackShape)

        shape.path = circlePath.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 22
        shape.strokeEnd = 0 // 線が切れる（見れなくなる）
        view.layer.addSublayer(shape)


        let button = UIButton(frame: CGRect(x: 100, y: view.frame.size.height - 200,
                                            width: view.frame.size.width - 100*2, height: 50))
        view.addSubview(button)
        button.setTitle("START", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
    }

    @objc func didTappedButton() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0.7 // 0.8で一周する！
        animation.duration = 2
        animation.isRemovedOnCompletion = false
//        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.fillMode = .forwards
        shape.add(animation, forKey: nil)
    }

}
