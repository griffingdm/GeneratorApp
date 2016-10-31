//
//  EquipmentViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/30/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class EquipmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 100.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentCell") as! EquipmentTableViewCell
        
//        print("\(allLabels!)")
//        
//        for patternView in cell.patternViews{
//            tileBG(view: patternView, image: #imageLiteral(resourceName: "dot-pttn"))
//        }
//        
//        cell.icon.image = theImages[indexPath.row]
//        
//        cell.header.text = headers[indexPath.row]
//        cell.number.text = ("0\(indexPath.row + 1)")
//        cell.layoutIfNeeded()
//        
//        for (index, labelText) in (allLabels![indexPath.row]?.enumerated())! {
//            print("\(index)")
//            print("\(labelText)")
//            cell.labels![index].text = labelText
//        }
        
        return cell
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
