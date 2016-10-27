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
    
    var aniDuration: TimeInterval = 0.25
    var springVel: CGFloat = 5
    var springDamp: CGFloat = 0.8
    
    var passKeyFrame: CGRect!
    var passKeyY: CGFloat!
    var passKeyBottom: CGFloat!
    var buttonUpDistance:CGFloat!
    
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
        
        print("passKeyBottom: \(passKeyBottom), keyboardTop: \(frame.origin.y)")
        
        //if frame.origin.y < passKeyBottom{
        print("going up!")
        UIView.animate(withDuration: aniDuration, animations: {
            self.mamaStack.frame.origin.y = frame.origin.y - self.mamaStack.frame.height
            self.topSectionParent.frame.origin.y += self.buttonUpDistance
        })
        //}
    }
    
    @IBAction func tapPowerUp(_ sender: AnyObject) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    override func viewDidLayoutSubviews() {
        passKeyFrame = passKeyStack.frame
        passKeyY = passKeyFrame.origin.y + mamaStack.frame.origin.y
        passKeyBottom = passKeyY + passKeyFrame.height
        buttonUpDistance = topSectionParent.frame.height - passKeyBottom
        
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
