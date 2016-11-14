//
//  EquipmentViewController.swift
//  GeneratorApp
//
//  Created by Abowd, Jonny on 10/30/16.
//  Copyright © 2016 Abowd, Jonny. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var equipment: [Equipment]!
    
    let threeDPrinter: Equipment = Equipment(eName: "TROTTER HEADS", eModel: "3D Printing", eImage: #imageLiteral(resourceName: "p-trotter-heads1"), eQuant: 2, eDetailImages: [#imageLiteral(resourceName: "p-trotter-heads2"), #imageLiteral(resourceName: "p-trotter-heads3")], eInstruct: "")
    let vinylCutter: Equipment = Equipment(eName: "GENERATOR STICKERS", eModel: "Vinyl Cutting", eImage: #imageLiteral(resourceName: "p-generator-sticker1"), eQuant: 1, eDetailImages: [#imageLiteral(resourceName: "p-generator-sticker2"), #imageLiteral(resourceName: "p-generator-sticker3")], eInstruct: "")
    let paperCutter: Equipment = Equipment(eName: "MONITOR STAND", eModel: "3D Printing", eImage: #imageLiteral(resourceName: "p-monitor-stand1"), eQuant: 4, eDetailImages: [#imageLiteral(resourceName: "p-monitor-stand2"), #imageLiteral(resourceName: "p-monitor-stand3")], eInstruct: "")
    
    var tabController: EquipmentTabViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        equipment = [threeDPrinter, vinylCutter, paperCutter]
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.contentInset.top = 100.0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
        let equip = equipment[indexPath.row]
        
        cell.equipment = equip
        print("\(cell.equipment.name!)")
        
        cell.equipImage.image = equip.image
        cell.nameLabel.text = equip.name
        cell.modelLabel.text = equip.model
        cell.quantity.text = "HRS-\(equip.qty!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EquipmentTableViewCell
        
        //print("segue!")
        tabController.performSegue(withIdentifier: "detailSegue", sender: cell)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
