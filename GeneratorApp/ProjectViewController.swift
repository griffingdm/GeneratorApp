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
    
    var equipment: [Project]!
    
    let trotterHeads: Project = Project(eName: "TROTTER HEADS", eModel: "3D Printing", eImage: #imageLiteral(resourceName: "p-trotter-heads1"), eQuant: 2, eDetailImages: [#imageLiteral(resourceName: "p-trotter-heads2"), #imageLiteral(resourceName: "p-trotter-heads3")], eInstruct: "PRINT TROTTER HEAD")
    let generatorStickers: Project = Project(eName: "GENERATOR STICKERS", eModel: "Vinyl Cutting", eImage: #imageLiteral(resourceName: "p-generator-sticker1"), eQuant: 1, eDetailImages: [#imageLiteral(resourceName: "p-generator-sticker2"), #imageLiteral(resourceName: "p-generator-sticker3")], eInstruct: "GENERATOR LOGO LAPTOP STICKER")
    let monitorStand: Project = Project(eName: "MONITOR STAND", eModel: "3D Printing", eImage: #imageLiteral(resourceName: "p-monitor-stand1"), eQuant: 4, eDetailImages: [#imageLiteral(resourceName: "p-monitor-stand2"), #imageLiteral(resourceName: "p-monitor-stand3")], eInstruct: "SERVICE MODELING PRINT")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        equipment = [trotterHeads, generatorStickers, monitorStand]
        
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
        
        cell.project = equip
        print("\(cell.project.name!)")
        
        cell.equipImage.image = equip.image
        cell.nameLabel.text = equip.name
        cell.modelLabel.text = equip.model
        cell.quantity.text = "HRS-\(equip.qty!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProjectTableViewCell
        
        //print("segue!")
        performSegue(withIdentifier: "projectDetailSegue", sender: cell)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // Pass the selected object to the new view controller.
        if segue.identifier == "projectDetailSegue" {
            let destination = segue.destination as! ProjectDetailViewController
            let cell = sender as! ProjectTableViewCell
            
            destination.view.layoutIfNeeded()
            
            var images = cell.project.detailImages
            
            destination.imageView.image = cell.equipImage.image
            destination.nameLabel.text = cell.nameLabel.text
            destination.modelLabel.text = cell.modelLabel.text
            destination.detailImageView1.image = images![0]
            destination.detailImageView2.image = images![1]
            destination.instructions = cell.project.instructionText
        }
    }
}
