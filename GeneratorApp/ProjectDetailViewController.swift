//
//  EquipmentDetailViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/1/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: SpaceLabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mamaStack: UIStackView!
    @IBOutlet weak var detailImageView1: UIImageView!
    @IBOutlet weak var detailImageView2: UIImageView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var equipment: Equipment!
    var instructions: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize.height = mamaStack.frame.height
        scrollView.frame = view.frame
    }
    
    func setUp(){
        nameLabel.text = equipment.name
        modelLabel.text = equipment.model
        imageView.image = equipment.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
