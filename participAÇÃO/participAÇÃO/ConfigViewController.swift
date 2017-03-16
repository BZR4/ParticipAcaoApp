//
//  ConfigViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 18/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PFLogInViewControllerDelegate {

    //MARK: - properties
    let options : [String] = [NSLocalizedString("Configuraçoões de localização", comment: "String that represents user location config"), NSLocalizedString("Categoria", comment: "Define users category preferences"), NSLocalizedString("Sair", comment: "Logout")]
    
    let images = ["map_config","category-config","sair"]
    
    @IBOutlet weak var configTable: UITableView!
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Configurações Gerais"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.configTable.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! ConfigurationTableViewCell
        
        cell.labelConfig.text = self.options[indexPath.row]
        cell.imageConfig.image = UIImage(named: images[indexPath.row])
        
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //perform segue programmatically from  another views
        
        self.configTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row{
        case 0:
            print("Irá para configuracoes do iOS!")
            return
        case 1:
            performSegueWithIdentifier("categories", sender: self)
            return
        case 2:
            logInScreen()
            return
        default:
            print("Algo falhou!")
        }
        
        
//        switch indexPath.row{
//            
//        case 0:
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("locationViewController") as UIViewController
//            self.presentViewController(vc, animated: true, completion: nil)
//            break
//            
//        case 1:
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("categoryViewContoller") as UIViewController
//            self.presentViewController(vc, animated: true, completion: nil)
//            break
//            
////        case 2:
////            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
////            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("perfilViewController") as UIViewController
////            self.presentViewController(vc, animated: true, completion: nil)
////            break
//            
//        case 2:
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("viewController") as UIViewController
//            self.presentViewController(vc, animated: false, completion: nil)
//            PFUser.logOut()
//            //self.logInScreen()
//        default:
//            print("ERROR")
//            
//        }
        
    }
    
    
    func logInScreen(){
        
        let logInController = MyLoginViewController()
        logInController.delegate = self
        
        logInController.fields = [.UsernameAndPassword, .PasswordForgotten,.LogInButton,.Facebook,.Twitter, .DismissButton]
        
        self.presentViewController(logInController, animated: true, completion: nil)
        
        
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "categories" {
//            let vc = segue.destinationViewController as! ConfigCategoriesViewController
//        }
//    }

    
    
}
