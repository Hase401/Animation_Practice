//
//  LaunchViewController.swift
//  BasicAnimation_Practice1
//
//  Created by 長谷川孝太 on 2021/07/11.
//

import UIKit

class LaunchViewController: UIViewController {

    /// LaunchScreen.storyboardと同じ画面をコードのみで作る？
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // UIをviewに追加している
        view.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 【疑問】このviewはsuperView(親View)なのかな？
        // 【メモ】frameはsuperViewが基準、boundsは現在のViewが基準
        // これがないと真ん中から始まらないだと！？
        // imageView.center は、superviewから見たときのimageViewの中心 → それにview.center(画面全体の真ん中)を代入
//        print(imageView.center)
        imageView.center = view.center
//        print(imageView.center)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate()
        }
    }

    private func animate() {

        UIView.animate(withDuration: 1, animations: {
//            print(self.view.frame.size) // widthとheightをプロパティとして持つ
            // self.view.frame ってsuperViewから見たときのsuperViewではなく？
            // viewControllerから見たときのviewか？
//            print(self)
//            print(self.view!)
//            print(self.view!.frame.size) // (390, 844)
            let size = self.view.frame.size.width * 2.2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2),
                                          y: diffY/2,
                                          width: size,
                                          height: size)
        })

        UIView.animate(withDuration: 1.25, animations: {
            self.imageView.alpha = 0
        }, completion: { _ in
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Main") as! MainViewController
            // 【メモ】mainVCではなく、navigaitonControllerに書く
//            mainVC.modalTransitionStyle = .crossDissolve
//            mainVC.modalPresentationStyle = .fullScreen
            let navigationController = UINavigationController(rootViewController: mainVC)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)


             // 【疑問メモ】これだと、navigaitonControllerが2つ合って、MainVCが２回呼ばれている！？
//            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Main") as! MainViewController
//            self.navigationController?.pushViewController(mainVC, animated: true)
        })
    }

}
