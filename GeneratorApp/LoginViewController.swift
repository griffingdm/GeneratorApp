//
//  LoginViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/23/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mamaStack: UIStackView!
    @IBOutlet weak var topSectionParent: UIView!
    @IBOutlet var buttonViewsToRound: [UIView]!
    @IBOutlet weak var powerUpButtonParentView: UIView!
    @IBOutlet weak var nameStack: UIStackView!
    //@IBOutlet weak var passKeyStack: UIStackView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameIdField: UITextField!
    @IBOutlet weak var pageHeader: SpaceLabel!
    @IBOutlet weak var enterNameLabelView: UIView!
    @IBOutlet weak var nameFieldLabel: SpaceLabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let limitLength: Int = 10
    
    var ogNameFrame: CGRect!
    var ogPasskeyFrame: CGRect!
    var ogTopSectionFrame: CGRect!
    var ogPowerButtonFrame: CGRect!
    
    var powerButtonY: CGFloat!
    var topSectionY: CGFloat!
    
    var aniDuration: TimeInterval = 0.25
    var springVel: CGFloat = 5
    var springDamp: CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameIdField.delegate = self
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to display
            self.showKeyboard(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to hide
            self.hideKeyboard(notification: notification)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //nameIdField.becomeFirstResponder()
        //UIView.animate(withDuration: 0) {
        //    self.passKeyStack.isHidden = true
        //}
        
        //ogPasskeyFrame = mamaStack.convert(passKeyStack.frame, from: passKeyStack.superview)
    }
    
    func showKeyboard(notification: Notification){
        // Get the size of the keyboard.
        print("show keyboard")
        var frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        frame = mamaStack.convert(frame, from: view)
        
        let powerButtonY: CGFloat = frame.origin.y - ogPowerButtonFrame.height
        //let topSectionY: CGFloat = powerButtonY - ogPasskeyFrame.origin.y - ogPasskeyFrame.height - 2
        let topSectionY: CGFloat = powerButtonY - ogNameFrame.origin.y - ogNameFrame.height - 2
        
        print("going up!")
        UIView.animate(withDuration: aniDuration, animations: {
            self.powerUpButtonParentView.frame.origin.y = powerButtonY
            self.topSectionParent.frame.origin.y = topSectionY
        })
    }
    
    func hideKeyboard(notification: Notification){
        print("going down!")
        UIView.animate(withDuration: aniDuration, animations: {
            self.powerUpButtonParentView.frame = self.ogPowerButtonFrame
            self.topSectionParent.frame = self.ogTopSectionFrame
        }, completion: { (Bool) in
            self.view.layoutSubviews()
            self.mamaStack.layoutSubviews()
        })
    }
    
    @IBAction func tapPowerUp(_ sender: AnyObject) {
        //performSegue(withIdentifier: "loginSegue", sender: nil)
        //performSegue(withIdentifier: "TabStorySegue", sender: nil)
        
        if (nameIdField.text?.characters.count)! < 1 {
            print("make it more than zero letters!")
            makeNameError()
        } else {
            appDelegate.user = nameIdField.text
            performSegue(withIdentifier: "GameSegue", sender: nil)
        }
    }
    
    func makeNameError(){
        if nameFieldLabel.superview?.layer.animationKeys()?.count == nil && nameFieldLabel.text == "ENTER NAME" {
            UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                self.nameFieldLabel.superview?.isHidden = true
                self.nameFieldLabel.alpha = 0
            }, completion: {(Bool) in
                self.nameFieldLabel.text = "ENTER A NAME!"
                UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                    self.nameFieldLabel.superview?.isHidden = false
                    self.nameFieldLabel.alpha = 1
                }, completion: {(Bool) in
                    delay(1, closure: {
                        self.returnNameError()
                    })
                })
            })
        }
    }
    
    func returnNameError(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            self.nameFieldLabel.superview?.isHidden = true
            self.nameFieldLabel.alpha = 0
        }, completion: {(Bool) in
            self.nameFieldLabel.text = "ENTER NAME"
            UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                self.nameFieldLabel.superview?.isHidden = false
                self.nameFieldLabel.alpha = 1
            }, completion: {(Bool) in
            })
        })
    }
    
    override func viewDidLayoutSubviews() {
        //self.passKeyStack.isHidden = true
        view.layoutIfNeeded()
        for buttonView in buttonViewsToRound{
            let cornerRadius: CGFloat = buttonView.frame.height / 2
            roundCorners(view: buttonView, radius: cornerRadius)
        }
        
        if appDelegate.user != nil {
            nameIdField.text = appDelegate.user
        }
        
        
        if ogTopSectionFrame == nil {
            ogTopSectionFrame = mamaStack.convert(topSectionParent.frame, from: topSectionParent.superview)
            ogPowerButtonFrame = mamaStack.convert(powerUpButtonParentView.frame, from: powerUpButtonParentView.superview)
            ogNameFrame = mamaStack.convert(nameStack.frame, from: nameStack.superview)
        }
    }
    
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        self.tapPowerUp(self)
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
