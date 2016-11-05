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
    @IBOutlet weak var parentTabStack: UIStackView!
    
    var gradientLayer: CAGradientLayer!
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    var materialController: MaterialsViewController!
    var equipmentController: EquipmentViewController!
    
    var dotViews: [UIView]!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let equipmentStroyboard = UIStoryboard(name: "EquipmentStoryboard", bundle: nil)
        equipmentController = equipmentStroyboard.instantiateViewController(withIdentifier: "equipment") as! EquipmentViewController
        materialController = equipmentStroyboard.instantiateViewController(withIdentifier: "materials") as! MaterialsViewController
        
        equipmentController.tabController = self
        
        viewControllers = [equipmentController, materialController]
        dotViews = [equipDot, materialDot]
        
        tapTab(tabButtons[selectedIndex])
        
        view.layoutIfNeeded()
        gradientLayer = vertGradient(topColor: topColor, bottomColor: bottomColor, frame: topGradient.frame, yStart: 0.8)
        view.layer.addSublayer(gradientLayer)
        view.bringSubview(toFront: parentTabStack)
    }
    
    override func viewDidLayoutSubviews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            let destination = segue.destination as! EquipmentDetailViewController
            let cell = sender as! EquipmentTableViewCell
            
            destination.view.layoutIfNeeded()
            
            var images = cell.equipment.detailImages
            
            destination.imageView.image = cell.equipImage.image
            destination.nameLabel.text = cell.nameLabel.text
            destination.modelLabel.text = cell.modelLabel.text
            destination.detailImageView1.image = images![0]
            destination.detailImageView2.image = images![1]
            destination.instructions = cell.equipment.instructionText 
        }
    }
}
