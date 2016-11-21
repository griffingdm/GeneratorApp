//
//  MaterialsViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/31/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class MaterialsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var theCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var errorStack: UIStackView!
    
    var theMaterials: [Material]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        theCollectionView.contentInset.top = 75.0
        theCollectionView.contentInset.bottom = 20
        if let flowLayout = theCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 160, height: 35)
        }
        
        errorStack.isHidden = true
        getMaterials()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: "MaterialCell", for: indexPath) as! MaterialCollectionViewCell
        //let material = materials[indexPath.row]
        let material = theMaterials[indexPath.row]
        
        //cell.materialImage.image = material.image
        cell.imageLink = material.imageURL
        cell.materialLabel.text = material.name
        cell.loadImage()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theMaterials.count
    }
    
    @IBAction func getMaterials() {
        activityIndicator.startAnimating()
        
        let query = PFQuery(className:"Material")
        //query.order(byDescending: "score")
        //query.limit = 100
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) materials.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId ?? "-")
                        let thisName = object["Name"] as! String
                        let imageURL = object["ImageURL"] as! String
                        
                        let newMaterial = Material(theName: thisName, imageLink: imageURL)
                        
                        print(object["Name"])
                        
                        self.theMaterials.append(newMaterial)
                    }
                    self.activityIndicator.stopAnimating()
                    self.theCollectionView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!)")
                print("THAT DIDNT WORK")
                self.errorStack.isHidden = false
            }
        }
    }
    
    @IBAction func tapRetry(_ sender: Any) {
        errorStack.isHidden = true
        getMaterials()
    }
    
    class Material{
        var image: UIImage?
        var name: String!
        var imageURL: String?
        
        init(picture: UIImage, theLabel: String) {
            image = picture
            name = theLabel
        }
        
        init(theName: String, imageLink: String) {
            name = theName
            imageURL = imageLink
        }
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

