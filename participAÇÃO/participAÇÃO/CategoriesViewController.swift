//
//  CategoriesViewController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/15/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class CategoriesViewController: UICollectionViewController {
    
    // MARK: - Variables and Constants
    let CellIdentifier = "categoriesCell"
    var allCategories: [Categories] = []
    
    // MARK: - IBAction's
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        TestLocal.saveTestArray([])
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategories()
        self.categoriesCollectionView.reloadData()
    }
    
    func loadCategories () {
        // TEMP
        let acc = CategoriesList()
        let loadCategories = TestLocal.getTestArray()
        if  loadCategories != []{
            let newArray = loadCategories.sort {$0 < $1}
            for category in newArray {
                acc.setCategories(category)
            }
            
            self.allCategories = acc.getArrayCategories()
        }
    }
    
    
    // MARK: - CollectionView DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCategories.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = self.categoriesCollectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! CategoriesCell
        
        let aCategory = self.allCategories[indexPath.item]
        
        cell.imgCategory.image = UIImage(named: aCategory.imgCaterory!)
        cell.lblTitleCategory.text = aCategory.titleCategory
        cell.imgFavorite.image = UIImage(named: "Star Filled-64.png")
        
        return cell
    }
    
    
    // MARK: - CollectionView Delegate
    // TODO: - Select a category
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.categoriesCollectionView.cellForItemAtIndexPath(indexPath) as! CategoriesCell
        
        if cell.imgFavorite.image == UIImage(named: "Star-64.png") {
            cell.imgFavorite.image = UIImage(named: "Star Filled-64.png")
        }
        else {
            cell.imgFavorite.image = UIImage(named: "Star-64.png")
        }
    }
}