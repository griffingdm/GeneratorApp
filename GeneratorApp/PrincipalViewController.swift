//
//  PrincipalViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/26/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class PrincipalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var theImages: [UIImage] = []
    var headers: [String]!
    var allLabels: [Int:[String]]!
    
    var tabViewController: TabViewController!
    
    //var gameScores: [GameScore]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        theImages = [#imageLiteral(resourceName: "icon-prin-1"),#imageLiteral(resourceName: "icon-prin-2"),#imageLiteral(resourceName: "icon-prin-3")]
        headers = ["FOR PLAYING ONLY", "LEARN, TEACH, REPEAT", "INSPIRE"]
        
        allLabels = [0: ["Supplies are for the space. Contact your manager to get your own.", "No reservations. No Meetings. First Come First Serve", "Do you work at capital One? You're allowed to use it."],
                     1: ["Do not use the 3D printer or vinyl cutter without training!", "Come hang out 10AM-11AM on Fridays to learn how everything works.", "If you have expertise you're willing to share, teach a class!"],
                     2: ["When you make something, brag about it!", "If you have an idea, let us know. We'll help you make it a reality.", "Create tutorials and off the processes of others."]
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 420
        
        //getTheScores()
        
        //tableView.tableHeaderView = tableView.dequeueReusableCell(withIdentifier: "principlesHeader")
        
        //let footerView: FooterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "footer") as! FooterTableViewCell
        //footerView.parentController = self
        //tableView.tableFooterView = footerView
    }
    
    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolled")
//        if scrollView.contentOffset.y < -10 {
//            print("refresh")
//            //tableView.reloadData()
//            tableView.cellForRow(at: IndexPath(item: 1, section: 0))?.awakeFromNib()
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell") as! ShareTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "circuitBreakCell") as! CircuitBreakerUITabTableViewCell
            cell.parentController = self
            
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "principlesHeader")
            return cell!
        default:
            let newIndex = indexPath.row - 3
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrincipleCell") as! PrincipalTableViewCell
            
            print("\(allLabels!)")
            
            cell.icon.image = theImages[newIndex]
            
            cell.header.text = headers[newIndex]
            cell.number.text = ("0\(newIndex + 1)")
            cell.layoutIfNeeded()
            
            for (index, labelText) in (allLabels![newIndex]?.enumerated())! {
                print("\(index)")
                print("\(labelText)")
                cell.labels![index].text = labelText
            }
            
            return cell
        }
    }
    
    @IBAction func tapLogo(_ sender: Any) {
        tabViewController.performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    
    @IBAction func tapRefresh(_ sender: UITapGestureRecognizer) {
        print("refresh")
        tableView.reloadData()
        tableView.cellForRow(at: IndexPath(item: 1, section: 0))?.awakeFromNib()
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
}
