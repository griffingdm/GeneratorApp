//
//  EquipmentTabViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/30/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class EquipmentTabViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet weak var equipDot: UIView!
    @IBOutlet weak var materialDot: UIView!
    @IBOutlet weak var topGradient: UIView!
    @IBOutlet weak var tabStack: UIStackView!
    
    var gradientLayer: CAGradientLayer!
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    var materialController: UIViewController!
    var equipmentController: UIViewController!
    
    var dotViews: [UIView]!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let equipmentStroyboard = UIStoryboard(name: "EquipmentStoryboard", bundle: nil)
        equipmentController = equipmentStroyboard.instantiateViewController(withIdentifier: "equipment")
        materialController = equipmentStroyboard.instantiateViewController(withIdentifier: "materials")
        viewControllers = [equipmentController, materialController]
        dotViews = [equipDot, materialDot]
        
        tapTab(tabButtons[selectedIndex])
    }
    
    override func viewDidLayoutSubviews() {
        setGradient(topColor: topColor, bottomColor: bottomColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setGradient(topColor: CGColor, bottomColor: CGColor){
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        self.gradientLayer.locations = [0, 1]
        self.gradientLayer.startPoint = CGPoint(x:0.5, y:0.75)
        self.gradientLayer.endPoint = CGPoint(x:0.5, y: 1)
        gradientLayer.frame = topGradient.frame
        view.layer.addSublayer(self.gradientLayer)
        view.bringSubview(toFront: tabStack)
    }
    
    @IBAction func tapTab(_ sender: AnyObject) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        dotViews[previousIndex].backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
        //tabButtons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        dotViews[selectedIndex].backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "dot-pttn"))
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
