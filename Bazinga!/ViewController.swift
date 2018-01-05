//
//  ViewController.swift
//  Bazinga!
//
//  Created by augustius cokroe on 04/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var allAccount : [Account] = []
    var allSubAccount : [SubAccount] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAccount()
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        do
        {
            allAccount = try managedContext.fetch(Account.fetchRequest())
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addAccount(name: String)
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let account = Account(context: managedContext)
        account.name = name
        if let subAccount = (account.childAccount as? [SubAccount])
        {
            for sub in subAccount
            {
                
            }
        }
        
        appDelegate.saveContext()
    }
    
    func deleteAccount(account:Account)
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(account)
        
        
        appDelegate.saveContext()
    }
    

}

