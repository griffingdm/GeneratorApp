//
//  GameEndViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/12/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import CoreData
import Parse

class GameEndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var leaderboardLabel: SpaceLabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var textureView: UIImageView!
    @IBOutlet weak var mamaStack: UIStackView!
    @IBOutlet weak var tableBG: DottedView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var resultString: String! = ""
    var score: Int = 0
    var gameScores: [GameScore] = []
    
    var gameController: GameViewController!
    
    var gradientFrame: CGRect!
    var theGradientLayer: CAGradientLayer!
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultLabel.text = resultString
        scoreLabel.text = "\(score) SURGES"
        
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        
        errorView.isHidden = false
        
        saveScore(theScore: score)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell") as! ScoreCellTableViewCell
        //let equip = equipment[indexPath.row]
        
//        cell.project = equip
//        print("\(cell.project.name!)")
//        
//        cell.equipImage.image = equip.image
//        cell.nameLabel.text = equip.name
//        cell.modelLabel.text = equip.model
//        cell.quantity.text = "HRS-\(equip.qty!)"
        
        let theName = gameScores[indexPath.row].playerName
        let theScore = gameScores[indexPath.row].score!
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        cell.NameLabel.text = theName
        cell.scoreLabel.text = "\(theScore)"
        
        if theName == getName()?[0].value(forKey: "name") as? String && theScore == score {
            cell.rankLabel.textColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
            cell.NameLabel.textColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
            cell.scoreLabel.textColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
        } else {
            cell.rankLabel.textColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
            cell.NameLabel.textColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
            cell.scoreLabel.textColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProjectTableViewCell
        
        //print("segue!")
        performSegue(withIdentifier: "projectDetailSegue", sender: cell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveScore(theScore: Int){
        let gameScore = PFObject(className:"GameScore")
        gameScore["score"] = score
        switch appDelegate.user {
        case nil:
            print("anonymous user")
            gameScore["playerName"] = "-"
        default:
            gameScore["playerName"] = getName()?[0].value(forKey: "name") as? String
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.errorView.isHidden = true
            self.activityIndicator.superview?.alpha = 1
        }, completion: { (Bool) in
        })
        
        activityIndicator.startAnimating()
        
        gameScore.saveInBackground { (success: Bool, error: Error?) in
            
            if (success) {
                // The object has been saved.
                print("saved!")
                self.getTheScores()
            } else {
                // There was a problem, check error.description
                print("did we make it?")
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.errorView.isHidden = false
                }, completion: { (Bool) in
                })
            }
        }
    }
    
    @IBAction func getTheScores() {
        
        let query = PFQuery(className:"GameScore")
        query.order(byDescending: "score")
        query.limit = 100
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId ?? "-")
                        let thisName = object["playerName"] as! String
                        let thisScore = object["score"] as! Int
                        
                        let newGameScore = GameScore(playerName: thisName, score: thisScore)
                        
                        print(object["playerName"])
                        
                        self.gameScores.append(newGameScore)
                    }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.superview?.alpha = 0
                    self.scoreTableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!)")
                print("THAT DIDNT WORK")
            }
        }
    }
    
    
    @IBAction func pressGiveUp(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {})
        
    }
    
    @IBAction func pressRestart(_ sender: UIButton) {
        dismiss(animated: true, completion:{
            self.gameController.surgesLabel.text = "PREPARE!"
            self.gameController.animateCircuit()
            self.gameController.scene.gameStart()
        })
        
    }
    
    override func viewDidLayoutSubviews() {
        //makeGradient()
        //view.layer.addSublayer(theGradientLayer)
        //view.bringSubview(toFront: textureView)
    }
    
    struct GameScore {
        var playerName: String!
        var score: Int!
    }
    
    func makeGradient(){
        let gHeight: CGFloat = 20.0
        gradientFrame = view.convert(mamaStack.frame, to: mamaStack.superview)
        gradientFrame = CGRect(x: gradientFrame.origin.x, y: gradientFrame.origin.y + gradientFrame.height - gHeight, width: gradientFrame.width, height: gHeight)
        theGradientLayer = vertGradient(topColor: topColor, bottomColor: bottomColor, frame: gradientFrame, yStart: 0)
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
