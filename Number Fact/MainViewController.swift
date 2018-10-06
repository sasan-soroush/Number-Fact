//
//  ViewController.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var buttonsMinY : CGFloat = 0

    private var buttonsMaxY : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
    
    }

    let statusView : UIView = {
        let v = UIView()
        v.backgroundColor = Colors.themeLight.rawValue
        return v
    }()
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.text = "Number Facts"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        return label
    }()
    
    let resultBackView : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.themeLight.rawValue
        view.layer.cornerRadius = 8
        return view
    }()
    
    let buttomView : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.themeLight.rawValue
        return view
    }()
    
    let textFieldView : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.themeLight.rawValue
        view.layer.cornerRadius = 8
        view.layer.borderColor = Colors.themeYellow.rawValue.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    let hitButtonView : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.background.rawValue
        view.clipsToBounds = true
        return view
    }()
    
    let hitButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "burn"), for: UIControlState.normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.themeYellow.rawValue.cgColor
        return button
    }()
    
    private func setupView() {
        
        view.backgroundColor = Colors.background.rawValue
        
        makeButtons()
        
        view.addSubview(statusView)
        view.addSubview(resultBackView)
        view.addSubview(buttomView)
        view.addSubview(hitButtonView)
        view.addSubview(hitButton)
        view.addSubview(textFieldView)
        view.addSubview(headerLabel)
        
        statusView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 20)
        resultBackView.frame = CGRect(x: 10, y: buttonsMaxY + 10, width: view.frame.width - 20, height: view.frame.height/3.5)
        buttomView.frame = CGRect(x: 0, y: view.frame.height/16 * 15, width: view.frame.width, height: view.frame.height/16)
        
        hitButtonView.frame = CGRect(x: view.frame.width/2 - buttomView.frame.height, y: view.frame.height/16*14, width: buttomView.frame.height*2, height: buttomView.frame.height*2)
        hitButtonView.layer.cornerRadius = buttomView.frame.height
        
        let hitButtonHeight = buttomView.frame.height*2 - 15
        hitButton.frame = CGRect(x: view.frame.width/2 - (hitButtonHeight)/2, y: buttomView.frame.minY - (hitButtonHeight)/2, width: hitButtonHeight, height: hitButtonHeight)
        hitButton.layer.cornerRadius = hitButtonHeight/2
        
        textFieldView.frame = CGRect(x: 10, y: resultBackView.frame.maxY + 10, width: view.frame.width - 20, height: hitButtonView.frame.minY - resultBackView.frame.maxY - 10)
        
        headerLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: buttonsMinY - 20)
        
    }
    
    private func makeButtons() {
        let margin = CGFloat(10)
        let buttonsHeight = view.frame.height/8
        let buttonsWidth = view.frame.width/2 - (margin*3)/2
        
        let mathButton = CustomButton(frame: CGRect(x: margin , y: buttonsHeight, width: buttonsWidth, height: buttonsHeight), Type: 1)
        
        let dateButton = CustomButton(frame: CGRect(x: mathButton.frame.maxX + (margin), y: buttonsHeight, width: buttonsWidth, height: buttonsHeight), Type: 2)
        
        let yearButton = CustomButton(frame: CGRect(x: margin, y: mathButton.frame.maxY + (margin), width: buttonsWidth, height: buttonsHeight), Type: 3)
        
        let triviaButton = CustomButton(frame: CGRect(x: mathButton.frame.maxX + (margin), y:mathButton.frame.maxY + (margin), width: buttonsWidth, height: buttonsHeight), Type: 4)
        buttonsMinY = mathButton.frame.minY
        buttonsMaxY = triviaButton.frame.maxY
        view.addSubview(mathButton)
        view.addSubview(dateButton)
        view.addSubview(yearButton)
        view.addSubview(triviaButton)
    }

}




















