//
//  MaterialsViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/31/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class MaterialsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var theCollectionView: UICollectionView!
    
    var materials: [Material]!
    let paintersTape: Material = Material(picture: #imageLiteral(resourceName: "m-blue-tape1"), theLabel: "Painter's Tape")
    let binderClips: Material = Material(picture: #imageLiteral(resourceName: "m-binder-clips1"), theLabel: "Binder Clips")
    let dryEraseMarkers: Material = Material(picture: #imageLiteral(resourceName: "m-dry-erase1"), theLabel: "Dry Erase Markers")
    let constructionPaper: Material = Material(picture: #imageLiteral(resourceName: "m-construction-paper1"), theLabel: "Construction Paper")
    let rubberBands: Material = Material(picture: #imageLiteral(resourceName: "m-rubberbands1"), theLabel: "Rubber Bands")
    let glueSticks: Material = Material(picture: #imageLiteral(resourceName: "m-glue-stick1"), theLabel: "Glue Sticks")
    let pipeCleaners: Material = Material(picture: #imageLiteral(resourceName: "m-pipe-cleaners1"), theLabel: "Pipe Cleaners")
    let postIts: Material = Material(picture: #imageLiteral(resourceName: "m-post-its1"), theLabel: "Post-Its")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        theCollectionView.contentInset.top = 100.0
        theCollectionView.contentInset.bottom = 20
        if let flowLayout = theCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 160, height: 35)
        }
        
        materials = [paintersTape, dryEraseMarkers, binderClips, constructionPaper]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: "MaterialCell", for: indexPath) as! MaterialCollectionViewCell
        let material = materials[indexPath.row]
        
        cell.materialImage.image = material.image
        cell.materialLabel.text = material.label
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.count
    }
    
    class Material{
        var image: UIImage!
        var label: String!
        
        init(picture: UIImage, theLabel: String) {
            image = picture
            label = theLabel
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

