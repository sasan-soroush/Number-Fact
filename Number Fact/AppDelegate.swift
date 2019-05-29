//
//  AppDelegate.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CAAnimationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UIApplication.shared.isStatusBarHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = Colors.background.rawValue
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        window?.setBackgroundImage(img: #imageLiteral(resourceName: "LaunchWithoutLogo"))
        //let navigationController = UINavigationController(rootViewController: MainViewController() )
        //animateLaunchScreen(navigationController)

        return true
    }

    private func animateLaunchScreen( _ navigationController : UINavigationController ) {
        // logo mask
        navigationController.view.layer.mask = CALayer()
        navigationController.view.layer.mask?.contents = #imageLiteral(resourceName: "Oval").cgImage
        navigationController.view.layer.mask?.bounds = CGRect(x: 0, y: 0, width: 00, height: 00)
        navigationController.view.layer.mask?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        navigationController.view.layer.mask?.position = CGPoint(x: navigationController.view.frame.width / 2, y: navigationController.view.frame.height / 2)
        
        // logo mask background view
        let maskBgView = UIView(frame: navigationController.view.frame)
        maskBgView.backgroundColor = UIColor.white
        navigationController.view.addSubview(maskBgView)
        navigationController.view.bringSubview(toFront: maskBgView)
        
        // logo mask animation
        let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimation.delegate = self
        transformAnimation.duration = 1
        transformAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(cgRect: (navigationController.view.layer.mask?.bounds)!)
        //        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        transformAnimation.values = [initalBounds , finalBounds]
        transformAnimation.keyTimes = [0  , 1]
        transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        transformAnimation.isRemovedOnCompletion = false
        transformAnimation.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask?.add(transformAnimation, forKey: "maskAnimation")
        
        // logo mask background view animation
        
        UIView.animate(withDuration: 0.1,delay: 0.75, options: UIViewAnimationOptions.curveEaseIn, animations: {
            maskBgView.alpha = 0.0
            
        }, completion: { finished in
            
            maskBgView.removeFromSuperview()
            //            navigationController.view.layer.mask?.contents = UIImage(named: "Oval.png")!.cgImage
            
            UIView.animate(withDuration: 0.25,delay: 0.0, options: [],animations: {
                
                self.window!.rootViewController!.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
                
            }, completion: { finished in
                
                UIView.animate(withDuration: 0.2,delay: 0.0,options:UIViewAnimationOptions.curveEaseInOut,animations: {
                    self.window!.rootViewController!.view.transform = .identity
                }, completion: nil)
                
            })
            
        })
    }

}

