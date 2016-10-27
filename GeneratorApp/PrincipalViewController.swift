//
//  PrincipalViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/26/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var theImages: [UIImage] = []
    var headers: [String]!
    var labels: [[String]]! = [[""],[""],[""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        theImages = [#imageLiteral(resourceName: "Screen Shot 2016-10-26 at 7.59.22 PM"),#imageLiteral(resourceName: "Screen Shot 2016-10-26 at 7.59.22 PM"),#imageLiteral(resourceName: "Screen Shot 2016-10-26 at 7.59.22 PM")]
        headers = ["FOR PLAYING ONLY", "LEARN, TEACH, REPEAT", "INSPIRE"]
        
        labels[0] = ["Supplies are for the space. Contact your manager to get your own.", "No reservations. No Meetings. First Come First Serve", "Do you work at capital One? You're allowed to use it."]
        labels.append(["Do not use the 3D printer or vinyl cutter without training!", "Come hang out 10AM-11AM on Fridays to learn how everything works.", "If you have expertise you're willing to share, teach a class!"])
        labels.append(["When you make something, brag about it!", "If you have an idea, let us know. We'll help you make it a reality.", "Create tutorials and off the processes of others."])
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 353
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrincipleCell") as! PrincipalTableViewCell
        //        cell.textLabel?.text = "This is row \(indexPath.row)"
        
        print("\(labels!)")
        
        for patternView in cell.patternViews{
            tileBG(view: patternView, image: #imageLiteral(resourceName: "dot-pttn"))
        }
        
        cell.icon = theImages[indexPath.row]
        cell.header.text = headers[indexPath.row]
        cell.number.text = ("0\(indexPath.row)")
        cell.layoutIfNeeded()
//        for (index, labelAr) in labels![indexPath.row].enumerated() {
//            print("\(index)")
//            cell.labels![index].text = labelAr
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
