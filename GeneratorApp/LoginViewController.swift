//
//  LoginViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/23/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mamaStack: UIStackView!
    @IBOutlet weak var topSectionParent: UIView!
    @IBOutlet var patternViews: [UIView]!
    @IBOutlet var buttonViewsToRound: [UIView]!
    @IBOutlet weak var powerUpButtonParentView: UIView!
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var passKeyStack: UIStackView!
    
    var topSectionFrame: CGRect!
    var powerButtonFrame: CGRect!
    var passkeyFrame: CGRect!
    
    var powerButtonY: CGFloat!
    var topSectionY: CGFloat!
    
    var aniDuration: TimeInterval = 0.25
    var springVel: CGFloat = 5
    var springDamp: CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for patternView in patternViews{
            tileBG(view: patternView, image: #imageLiteral(resourceName: "dot-pttn"))
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to display
            self.showKeyboard(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to hide
        }
        
    }
    
    func showKeyboard(notification: Notification){
        // Get the size of the keyboard.
        print("show keyboard")
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        topSectionFrame = mamaStack.convert(topSectionParent.frame, from: topSectionParent.superview)
        powerButtonFrame = mamaStack.convert(powerUpButtonParentView.frame, from: powerUpButtonParentView.superview)
        passkeyFrame = mamaStack.convert(passKeyStack.frame, from: passKeyStack.superview)
        
        let powerButtonY: CGFloat = frame.origin.y - powerButtonFrame.height
        let topSectionY: CGFloat = powerButtonY - passkeyFrame.origin.y - passkeyFrame.height - 2
        
        //if frame.origin.y < passKeyBottom{
        print("going up!")
        UIView.animate(withDuration: aniDuration, animations: {
            self.powerUpButtonParentView.frame.origin.y = powerButtonY
            self.topSectionParent.frame.origin.y = topSectionY
        })
        //}
    }
    
    @IBAction func tapPowerUp(_ sender: AnyObject) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    override func viewDidLayoutSubviews() {
        for buttonView in buttonViewsToRound{
            let cornerRadius: CGFloat = buttonView.frame.height / 2
            roundCorners(view: buttonView, radius: cornerRadius)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
