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
    
    var equipment: [Equipment]!
    let threeDPrinter: Equipment = Equipment(eName: "3D PRINTER", eModel: "Flashforge Creator Pro", eImage: #imageLiteral(resourceName: "FlashforgeCreatorProNew2016_FFEU_Bild1"), eQuant: 1)
    let vinylCutter: Equipment = Equipment(eName: "VINYL CUTTER", eModel: "Roland GS-24", eImage: #imageLiteral(resourceName: "gs24standwide"), eQuant: 1)
    let paperCutter: Equipment = Equipment(eName: "PAPER CUTTER", eModel: "Rotatrim RCM30", eImage: #imageLiteral(resourceName: "paper cutter"), eQuant: 1)
    
    var tabController: EquipmentTabViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        equipment = [threeDPrinter, vinylCutter, paperCutter]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 100.0
        tableView.contentInset.bottom = 20
        
        tableView.estimatedRowHeight = 195
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableHeaderView = tableView.dequeueReusableCell(withIdentifier: "header")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentCell") as! EquipmentTableViewCell
        let equip = equipment[indexPath.row]
        
        cell.equipImage.image = equip.image
        cell.nameLabel.text = equip.name
        cell.modelLabel.text = equip.model
        cell.quantity.text = "QTY-\(equip.qty!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EquipmentTableViewCell
        
        
        //print("segue!")
        tabController.performSegue(withIdentifier: "detailSegue", sender: cell)
    }
    
    struct Equipment {
        var name: String!
        var model: String!
        var image: UIImage!
        var qty: Int!
        
        init(eName: String, eModel: String, eImage: UIImage, eQuant: Int) {
            name = eName
            model = eModel
            image = eImage
            qty = eQuant
        }
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
}
