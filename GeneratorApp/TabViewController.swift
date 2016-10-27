//
//  TabViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/26/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!

    @IBOutlet var tabButtons: [UIButton]!
    
    var principalController: UIViewController!
    var projectsController: UIViewController!
    var equipmentController: UIViewController!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        principalController = storyboard.instantiateViewController(withIdentifier: "controller0")
        projectsController = storyboard.instantiateViewController(withIdentifier: "controller1")
        equipmentController = storyboard.instantiateViewController(withIdentifier: "controller2")
        viewControllers = [principalController, projectsController, equipmentController]
        
        tapTab(tabButtons[selectedIndex])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapTab(_ sender: AnyObject) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        tabButtons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        tabButtons[selectedIndex].isSelected = true
        let selectedVC = viewControllers[selectedIndex]
        addChildViewController(selectedVC)
        selectedVC.view.frame = contentView.bounds
        contentView.addSubview(selectedVC.view)
        selectedVC.didMove(toParentViewController: self)
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
