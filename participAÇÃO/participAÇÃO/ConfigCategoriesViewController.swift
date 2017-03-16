//
//  ConfigCategoriesViewController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/18/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class ConfigCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables and Constants
    var arrayAllCategories: [Categories] = []
    var arrayCategoriesSelected: [String] = []
    var loadCategoriesSaved: [String] = []
    
    // MARK: - IBOutlet's
    @IBOutlet weak var configCategoryTableView: UITableView!
    let images = ["educacao_final","meio_ambiente_final","saude_final","seguranca_final","convivencia_final","transito_final","lazer_final","mobilidade_final"]
//    let category = ["Aeroporto","Água e esgoto","Estabelecimento irregular","Iluminação e energia","Limpeza e conservação",
//        "Meio Ambiente","Pedestre e ciclistas","Saúde", "Segurança","Transporte público", "Urbanismo", "Vias e transito"]
    
    let category = ["Educação","Meio Ambiente","Saúde","Segurança","Convivência","Transito","Lazer","Mobilidade Urbana"]
    
    let colors: [UIColor]? = [
        UIColor(red: 232.0/255.0, green: 87.0/255.0, blue: 103.0/255.0, alpha: 1),
        UIColor(red: 214.0/255.0, green: 72.0/255.0, blue: 87.0/255.0, alpha: 1),
        UIColor(red: 248.0/255.0, green: 112.0/255.0, blue: 87.0/255.0, alpha: 1),
        UIColor(red: 229.0/255.0, green: 89.0/255.0, blue: 69.0/255.0, alpha: 1),
        UIColor(red: 252.0/255.0, green: 206.0/255.0, blue: 95.0/255.0, alpha: 1),
        UIColor(red: 243.0/255.0, green: 187.0/255.0, blue: 59.0/255.0, alpha: 1),
        //
        UIColor(red: 232.0/255.0, green: 87.0/255.0, blue: 103.0/255.0, alpha: 1),
        UIColor(red: 214.0/255.0, green: 72.0/255.0, blue: 87.0/255.0, alpha: 1),
        UIColor(red: 248.0/255.0, green: 112.0/255.0, blue: 87.0/255.0, alpha: 1),
        UIColor(red: 229.0/255.0, green: 89.0/255.0, blue: 69.0/255.0, alpha: 1),
        UIColor(red: 252.0/255.0, green: 206.0/255.0, blue: 95.0/255.0, alpha: 1),
        UIColor(red: 243.0/255.0, green: 187.0/255.0, blue: 59.0/255.0, alpha: 1)
    ]
    
    
    //LightGray,  MediumGray,  DarkGray, BlueJeans, BlueJeansClear, Lavander, LavanderClear, PinkRose, PinkRoseClear
    
    enum CustomColors {
        case GrapeFruit, GrapeFruitClear, BitterSweet, BitterSweetClear, SunFlower, SunFlowerClear, Grass, GrassClear, Mint, MintClear, Aqua, AquaClear
    }
//    
//    func customColors() -> UIColor{
//        
//    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoriesList = CategoriesList()
        categoriesList.categoriesTest()
        self.arrayAllCategories = categoriesList.getArrayCategories()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategoriesSaved = TestLocal.getTestArray()
        loadCategoriesSaved = loadCategoriesSaved.sort {$0 < $1}
    }
    
    
    
    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.arrayAllCategories.count
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
//        headerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        headerView.alpha = 1
        return headerView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.category.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "ConfigCell2"
        
        let cell = self.configCategoryTableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! ConfigCategoriesCell
        
//        let aCategory = self.arrayAllCategories[indexPath.row]
        let aCategory = self.arrayAllCategories[indexPath.section]
        
        // Config Cell
//        cell.imgCategory.image = UIImage(named: aCategory.imgCaterory!)
//        cell.lblTitleCategory.text = aCategory.titleCategory
        
        cell.titleCategory.text = category[indexPath.section]
//        cell.titleCategory.textColor = colors![indexPath.section]
//        cell.descriptionCategory.text = category[indexPath.section]
//        cell.descriptionCategory.textColor = colors![indexPath.section]
        cell.iconCategory.image = UIImage(named: images[indexPath.section])
        cell.iconCategory.tintColor = colors![indexPath.section]
//        cell.backgroundColor = colors![indexPath.section]
        
        cell.backgroundColor = UIColor.whiteColor()
        
        
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 222.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha: 1).CGColor
        cell.layer.cornerRadius = 8
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowOffset = CGSizeMake(0, 2)
        cell.layer.shadowRadius = 1
        cell.layer.masksToBounds = false
        cell.clipsToBounds = false

        
//        
        
        
        
        var starCategory = "adicionar"
        for compareCategory in self.loadCategoriesSaved {
            if compareCategory == aCategory.titleCategory {
                starCategory = "checked2"
            }
        }
        cell.imgFavorite.image = UIImage(named: starCategory)
        
        return cell
    }
    
    
    // MARK: - TableView Delegate
    // TODO: SINCRONIZAR COM BACKEND (SALVANDO TEMPORARIAMENTE EM UM USER DEFAULTS - 'REDUNDANTE')
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.configCategoryTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = self.configCategoryTableView.cellForRowAtIndexPath(indexPath) as! ConfigCategoriesCell
        
        // TODO: CONFIRMAR QUAL MELHOR FORMA DE PASSAR AS CATEGORIAS
        if loadCategoriesSaved != [] {
            self.arrayCategoriesSelected = loadCategoriesSaved
        }
        
        if cell.imgFavorite.image == UIImage(named: "adicionar") {
            cell.imgFavorite.image = UIImage(named: "checked2")
            
            self.arrayCategoriesSelected.append(cell.titleCategory.text!)
            TestLocal.saveTestArray(self.arrayCategoriesSelected)
        }
        else {
            cell.imgFavorite.image = UIImage(named: "adicionar")
            removeACategory(cell.titleCategory.text!)
        }
    }
    
    // Method to remove a category had selected
    func removeACategory (categoryName: String) {
        var position = 0
        for aCategory in arrayCategoriesSelected {
            if aCategory == categoryName {
                self.arrayCategoriesSelected.removeAtIndex(position)
                TestLocal.saveTestArray(self.arrayCategoriesSelected)
            }
            position++
        }
    }
    
    
    // TODO: MUDAR!!!
    
    @IBAction func removerViewCategorias(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


