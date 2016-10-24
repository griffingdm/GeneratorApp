//
//  LoginViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/23/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var patternViews: [UIView]!
    @IBOutlet var buttonViewsToRound: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for patternView in patternViews{
            tileBG(view: patternView, image: #imageLiteral(resourceName: "dot-pttn"))
        }
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
