//
//  ViewController.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import AVFoundation

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
        
        textFieldView.addSubview(numberTextField)
        textFieldView.addSubview(monthTextField)
        textFieldView.addSubview(dayTextField)
        resultBackView.addSubview(resultTextView)
        
        view.addSubview(blurredEffectView)
        view.addSubview(customIndicator)
        
        numberTextField.delegate = self
        dayTextField.delegate = self
        monthTextField.delegate = self
        
        blurredEffectView.frame = view.frame
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
        
        let dateTieldWidth = textFieldView.frame.width/4
        monthTextField.frame = CGRect(x: dateTieldWidth, y: 0, width: dateTieldWidth - margin/2, height: textFieldView.frame.height)
        dayTextField.frame = CGRect(x: textFieldView.frame.midX+margin/2, y: 0, width: dateTieldWidth - margin/2, height: textFieldView.frame.height)
        
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
    
    func startLoading() {
        self.vibrate()
        self.blurredEffectView.isHidden = false
        self.view.isUserInteractionEnabled = false
        self.customIndicator.startAnimating()
    }
    
    func stopLoading() {
        self.vibrate()
        self.blurredEffectView.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.customIndicator.stopAnimating()
    }
    
    private func resetPage() {
        self.vibrate()
        self.numberTextField.text = ""
        self.monthTextField.text = ""
        self.dayTextField.text = ""
        
    }
    
    fileprivate func getNumberInfo(_ type: InformationTypes?) {
        startLoading()
        API.getInformation(number: UInt(numberTextField.text!)!, type: type!) { (success, response) in
            DispatchQueue.main.async {
                self.stopLoading()
                if success , response != nil {
                    self.resultTextView.text = response!.text ?? "This number has uncovered secrets in this era."
                } else {
                    Helper.alert(self, title: "", body: "Something Went Wrong!!\nPlease try again later")
                }
            }
        }
    }
    
    fileprivate func getDateInfo() {
        if dayTextField.text != "" , monthTextField.text != ""  {
            if UInt8(dayTextField.text!) != nil , UInt8(monthTextField.text!) != nil {
                startLoading()
                API.getDateInformation(day: UInt8(dayTextField.text!)!, month: UInt8(monthTextField.text!)!) { (success, response) in
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.blurredEffectView.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.customIndicator.stopAnimating()
                        if success , response != nil {
                            self.resultTextView.text = response!.text ?? "This number has uncovered secrets in this era."
                        } else {
                            Helper.alert(self, title: "", body: "Something Went Wrong!!\nPlease try again later")
                        }
                    }
                }
            }
        }
    }
    
    @objc private func buttonTapped(button : UIButton) {
        
        if button.tag == 5 {
            
            if selectedButtonTag == 2 {
                getDateInfo()
            } else {
                guard numberTextField.text != ""  else {
                    Helper.alert(self, title: "", body: "Please Enter a Number.")
                    return
                }
                
                guard  UInt(numberTextField.text!) != nil else {
                    Helper.alert(self, title: "", body: "Please Enter a Valid Number.")
                    return
                }
                
                if !isExpanded {
                    Helper.alert(self, title: "Choose Fact Type", body: "Please choose one of above options.")
                    return
                }
                
                var type : InformationTypes?
                
                switch selectedButtonTag {
                case 1 :
                    type = .math
                    break
                case 3 :
                    type = .year
                    break
                case 4 :
                    type = .trivia
                    break
                default :
                    type = nil
                }
                
                guard type != nil else {
                    Helper.alert(self, title: "Choose Fact Type", body: "Please choose one of above options.")
                    return
                }
                
                getNumberInfo(type)
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
        self.selectedButtonTag = selectedButton.tag
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            deselectedButtons.forEach {$0.alpha = 0}
            selectedButton.frame = CGRect(x: self.margin, y: self.buttonsHeight, width: self.view.frame.width - self.margin*2, height: self.buttonsHeight*2 + self.margin)
            
            self.handleExpandingBackground(selectedButton)
            
        }) { (success) in
            if success {
                self.isExpanded = true
                self.setTextFieldsToDate(selectedButton.tag == 2)
            }
        }
    }
    
    private func setTextFieldsToDate(_ dateMode : Bool) {
        self.numberTextField.isHidden = dateMode ? true : false
        self.monthTextField.isHidden = dateMode ? false : true
        self.dayTextField.isHidden = dateMode ? false : true
    }
    
    fileprivate func minimizeButtons(_ deselectedButtons: [UIButton], _ selectedButton: UIButton) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            deselectedButtons.forEach {$0.alpha = 1}
            selectedButton.frame = self.initialFrame
            self.handleExpandingBackground(selectedButton)
            self.resetPage()
            
        }) { (success) in
            if success {
                self.isExpanded = false
                if selectedButton.tag == 2 {
                    self.setTextFieldsToDate(false)
                }
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
    
    private func vibrate() {
        
        
        do {
            
            AudioServicesPlaySystemSound(1521)
            
        } catch {
            print ("There is an issue with this code!")
        }
    }
}

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.frame = view.frame
        logoAnimationView.logoGifImageView?.delegate = self
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView?.startAnimatingGif()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension MainViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        setupView()
        addKeyboardNotifiactions()
    }
}

extension MainViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    fileprivate func showKeyboardAnimation(_ keyboardSize: CGRect? , open : Bool) {
        
        
        self.resultBackView.alpha = open ? 0 : 1
        self.buttomView.alpha = open ? 0 : 1
        self.hitButton.alpha = open ? 0 : 1
//        if buttonsValid() {
//
//            let buttons : [UIButton] = [mathButton!, triviaButton!, yearButton!, dateButton!]
//            let unselectedOnes = buttons.filter {$0.tag != selectedButtonTag}
//            unselectedOnes.forEach{$0.alpha = open ? 0 : 1}
//        }
        if open {
            if buttonsValid() {
                self.textFieldView.frame.origin.y = triviaButton!.frame.maxY + margin
            }
        } else {
            self.textFieldView.frame.origin.y = resultBackView.frame.maxY + 10
        }
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.showKeyboardAnimation(keyboardSize, open: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if textFieldView.frame.origin.y != 0 {
            self.showKeyboardAnimation(nil, open: false)
        }
    }
    
}

extension MainViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isExpanded {
            Helper.alert(self, title: "Choose Fact Type", body: "Please choose one of above options.")
            textField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        switch textField.tag {
        case 2:
            return setLimitations(textField: textField, string: string, range: range, countLimit: 2, characters: "1234567890")
        case 3:
            return setLimitations(textField: textField, string: string, range: range, countLimit: 2, characters: "1234567890")
        default:
            
            var limit = 18
            if selectedButtonTag == 3 {
                limit = 4
            }
            return setLimitations(textField: textField, string: string, range: range, countLimit: limit, characters: "1234567890")
        }
    }
    
    private func setLimitations(textField : UITextField , string : String ,range : NSRange, countLimit : Int , characters : String) -> Bool {
        var isValidAmount = true
        guard let txt = textField.text else {return false}
        guard let stringToInt = Int(String(txt + string)) else {return false}
        isValidAmount = txt.count <= countLimit
        
        switch textField.tag {
        case 2:
            isValidAmount = stringToInt <= 12
        case 3:
            isValidAmount = stringToInt <= 31
        default:
            isValidAmount = true
        }
        
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        let aSet = NSCharacterSet(charactersIn:characters).inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered && count <= countLimit && isValidAmount
    }
}

class MainViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let logoAnimationView = LogoAnimationView()
    
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
    
    private var selectedButtonTag : Int = 0
    
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
    
    
    let blurredEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        return view
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
        field.tag = 1
        return field
    }()
    
    let monthTextField : BaseTextField = {
        let field = BaseTextField()
        field.placeholder = "Month"
        field.tag = 2
        field.isHidden = true
        return field
    }()
    
    let dayTextField : BaseTextField = {
        let field = BaseTextField()
        field.placeholder = "Day"
        field.tag = 3
        field.isHidden = true
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




















