//
//  ViewController.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

extension MainViewController {
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
        view.addSubview(customIndicator)
        textFieldView.addSubview(numberTextField)
        resultBackView.addSubview(resultTextView)
        
        statusView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 20)
        resultBackView.frame = CGRect(x: 10, y: buttonsMaxY + 10, width: view.frame.width - 20, height: view.frame.height/3.5)
        buttomView.frame = CGRect(x: 0, y: view.frame.height/16 * 15, width: view.frame.width, height: view.frame.height/16)
        
        hitButtonView.frame = CGRect(x: view.frame.width/2 - buttomView.frame.height, y: view.frame.height/16*14, width: buttomView.frame.height*2, height: buttomView.frame.height*2)
        hitButtonView.layer.cornerRadius = buttomView.frame.height
        
        let hitButtonHeight = buttomView.frame.height*2 - 15
        hitButton.frame = CGRect(x: view.frame.width/2 - (hitButtonHeight)/2, y: buttomView.frame.minY - (hitButtonHeight)/2, width: hitButtonHeight, height: hitButtonHeight)
        hitButton.layer.cornerRadius = hitButtonHeight/2
        
        textFieldView.frame = CGRect(x: 10, y: resultBackView.frame.maxY + 10, width: view.frame.width - 20, height: hitButtonView.frame.minY - resultBackView.frame.maxY - 10)
        
        numberTextField.frame = CGRect(x: margin, y: 0, width: textFieldView.frame.width - margin * 2, height: textFieldView.frame.height)
        
        resultTextView.frame = CGRect(x: margin*2, y: margin*2, width: resultBackView.frame.width - margin*4, height: resultBackView.frame.height - margin*4)
        
        headerLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: buttonsMinY - 20)
        
    }
    
    private func makeButtons() {
        
        mathButton = CustomButton(frame: CGRect(x: margin , y: buttonsHeight, width: buttonsWidth, height: buttonsHeight), Type: 1)
        
        dateButton = CustomButton(frame: CGRect(x: mathButton!.frame.maxX + (margin), y: buttonsHeight, width: buttonsWidth, height: buttonsHeight), Type: 2)
        
        yearButton = CustomButton(frame: CGRect(x: margin, y: mathButton!.frame.maxY + (margin), width: buttonsWidth, height: buttonsHeight), Type: 3)
        
        triviaButton = CustomButton(frame: CGRect(x: mathButton!.frame.maxX + (margin), y:mathButton!.frame.maxY + (margin), width: buttonsWidth, height: buttonsHeight), Type: 4)
        
        mathButton?.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        dateButton?.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        yearButton?.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        triviaButton?.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        
        buttonsMinY = mathButton!.frame.minY
        buttonsMaxY = triviaButton!.frame.maxY
        
        view.addSubview(mathButton!)
        view.addSubview(dateButton!)
        view.addSubview(yearButton!)
        view.addSubview(triviaButton!)
    }
}

extension MainViewController {
    
    @objc private func buttonTapped(button : UIButton) {
        
        if button.tag == 5 {
            
            self.view.alpha = 0.5
            self.view.isUserInteractionEnabled = false
            self.customIndicator.startAnimating()
            
            if numberTextField.text == "" {
                Helper.alert(self, title: "", body: "Please Enter a Number.")
                return
            }
            
            if UInt(numberTextField.text!) == nil {
                Helper.alert(self, title: "", body: "Please Enter a Valid Number.")
                return
            }
            
            API.getInformation(number: UInt(numberTextField.text!)!, type: InformationTypes.math) { (success, response) in
                DispatchQueue.main.async {
                    self.view.alpha = 1
                    self.view.isUserInteractionEnabled = true
                    self.customIndicator.stopAnimating()
                    if success , response != nil {
                        self.resultTextView.text = response!.text ?? "This number has uncovered secrets in this era."
                    } else {
                        Helper.alert(self, title: "", body: "Something Went Wrong!!\nPlease try again later")
                    }
                }
            }
        } else {
            selectButton(selectedButton: button)
        }
    }
    
    fileprivate func handleExpandingBackground(_ selectedButton : UIButton) {
        switch selectedButton.tag {
        case 1:
            selectedButton.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xA21EFC), secondColor: UIColor.init(rgb: 0x564EFE))
        case 2:
            selectedButton.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xFD66B2), secondColor: UIColor.init(rgb: 0xFC8B64))
        case 3:
            selectedButton.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0x42D7C4), secondColor: UIColor.init(rgb: 0x119ED6))
        case 4:
            selectedButton.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xF0BC66), secondColor: UIColor.init(rgb: 0xEE6A35))
        default :
            break
        }
    }
    
    fileprivate func expandButton(_ deselectedButtons: [UIButton], _ selectedButton: UIButton) {
        self.initialFrame = selectedButton.frame
        self.view.bringSubview(toFront: selectedButton)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            deselectedButtons.forEach {$0.alpha = 0}
            selectedButton.frame = CGRect(x: self.margin, y: self.buttonsHeight, width: self.view.frame.width - self.margin*2, height: self.buttonsHeight*2 + self.margin)
            
            self.handleExpandingBackground(selectedButton)
            
        }) { (success) in
            if success {
                self.isExpanded = true
            }
        }
    }
    
    fileprivate func minimizeButtons(_ deselectedButtons: [UIButton], _ selectedButton: UIButton) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            deselectedButtons.forEach {$0.alpha = 1}
            selectedButton.frame = self.initialFrame
            self.handleExpandingBackground(selectedButton)
            
        }) { (success) in
            if success {
                self.isExpanded = false
            }
        }
    }
    
    private func selectButton(selectedButton : UIButton) {
        
        if buttonsValid() {
            let buttons : [UIButton] = [mathButton! , triviaButton! , yearButton! , dateButton!]
            let deselectedButtons = buttons.filter {$0 != selectedButton}
            
            if isExpanded {
                minimizeButtons(deselectedButtons, selectedButton)
            } else {
                expandButton(deselectedButtons, selectedButton)
            }
        }
    }
    
    private func buttonsValid() -> Bool {
        var canContinue : Bool = true
        let buttons : [UIButton?] = [mathButton , triviaButton , yearButton , dateButton]
        
        for button in buttons {
            if button == nil {
                canContinue = false
            }
        }
        return canContinue
    }
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addKeyboardNotifiactions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension MainViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.resultBackView.alpha = 0
                
                self.view.frame.origin.y -= (keyboardSize.height+50)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.resultBackView.alpha = 1
            self.view.frame.origin.y = 0
        }
    }
    
}

class MainViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private let margin : CGFloat = 10
    private let animationDuration : TimeInterval = 0.5

    private var buttonsMinY : CGFloat = 0
    private var buttonsMaxY : CGFloat = 0
    
    private var mathButton : CustomButton?
    private var dateButton : CustomButton?
    private var yearButton : CustomButton?
    private var triviaButton : CustomButton?
    
    private var isExpanded : Bool = false
    private var initialFrame : CGRect = .zero
    
    lazy var buttonsHeight = view.frame.height/8
    lazy var buttonsWidth = view.frame.width/2 - (margin*3)/2
    
    lazy var customIndicator = Helper.customIndicator(view)
    
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
    
    let resultTextView : BaseTextView = {
        let view = BaseTextView()
        view.textColor = UIColor.white.withAlphaComponent(0.75)
        view.textAlignment = .center
        view.tintColor = .white
        view.isEditable = false
        view.backgroundColor = .clear
        view.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.regular)
        view.text = "Just Like Us Every Number Has a Secret."
        return view
    }()
    
    let numberTextField : BaseTextField = {
        let field = BaseTextField()
        field.placeholder = "Type Number Here"
        field.textAlignment = .center
        field.textColor = .white
        field.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.semibold)
        field.tintColor = .white
        field.keyboardType = .numberPad
        field.keyboardAppearance = .dark
        return field
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
        button.tag = 5
        button.addTarget(self, action: #selector(buttonTapped(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()
}




















