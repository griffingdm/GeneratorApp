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
    @IBOutlet weak var bottomGradient: UIView!
    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet var tabImageViews: [UIImageView]!
    @IBOutlet weak var textureView: UIView!
    
    
    //let textureImage = #imageLiteral(resourceName: "texture-test3")
    
    var gradientLayer: CAGradientLayer!
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    var principalController: PrincipalViewController!
    var projectsController: UIViewController!
    var equipmentController: UIViewController!
    
    var defaultImages: [UIImage]!
    var selectedImages: [UIImage]!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        let equipmentStoryboard = UIStoryboard(name: "EquipmentStoryboard", bundle: nil)
        let principleStoryboard = UIStoryboard(name: "PrincipleStoryboard", bundle: nil)
        let projectStoryboard = UIStoryboard(name: "ProjectStoryboard", bundle: nil)
        principalController = principleStoryboard.instantiateViewController(withIdentifier: "controller0") as! PrincipalViewController
        projectsController = projectStoryboard.instantiateViewController(withIdentifier: "controller0")
        equipmentController = equipmentStoryboard.instantiateViewController(withIdentifier: "controller0")
        viewControllers = [projectsController, principalController, equipmentController]
        defaultImages = [#imageLiteral(resourceName: "nav-icon-proj"), #imageLiteral(resourceName: "nav-icon-prin"), #imageLiteral(resourceName: "nav-icon-equip")]
        selectedImages = [#imageLiteral(resourceName: "nav-icon-proj-active") , #imageLiteral(resourceName: "nav-icon-prin-active"), #imageLiteral(resourceName: "nav-icon-equip-active")]
        
        tapTab(tabButtons[selectedIndex])
        
        principalController.tabViewController = self
        
        view.layoutIfNeeded()
        let gradientFrame = view.convert(bottomGradient.frame, to: bottomGradient.superview)
        let gradientLayer = vertGradient(topColor: topColor, bottomColor: bottomColor, frame: gradientFrame, yStart: 0)
        view.layer.addSublayer(gradientLayer)
        view.bringSubview(toFront: textureView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    @IBAction func tapTab(_ sender: AnyObject) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        for tabImage in tabImageViews {
            if tabImage.tag == previousIndex && previousIndex != selectedIndex {
                tabImage.image = defaultImages[previousIndex]
            } else if tabImage.tag == selectedIndex {
                tabImage.image = selectedImages[selectedIndex]
            }
        }
        
        //tabButtons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        //tabButtons[selectedIndex].isSelected = true
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
