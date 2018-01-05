//
//  AccountForm.swift
//  Bazinga!
//
//  Created by augustius cokroe on 13/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AccountForm: UIViewController
{
    @IBOutlet var AccountTableView: UITableView!
    var allAccount:NSFetchedResultsController<Account> = NSFetchedResultsController()
    
    //MARK:View cycle
    override func viewDidLoad() {
        
        allAccount = SharedModel.shared.getAllAccount(delegate: self as NSFetchedResultsControllerDelegate)
    }
    
}

// MARK: UITableViewDelegate method
extension AccountForm: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAccount.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        
        cell.textLabel?.text = allAccount.object(at: indexPath).name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editAccount", sender: allAccount.object(at: indexPath))
    }
}

//MARK: Segue method
extension AccountForm
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAccount"{
            
            guard
                let dvc = segue.destination as? AddAccountForm,
                let selectedAccount = sender as? Account
                else { print("error on \(#function), \(#line) "); return}
            
            dvc.currentAccount = selectedAccount
            dvc.usage = .edit
        }
    }
    
    @IBAction func unwindToAccountForm(segue: UIStoryboardSegue) {
        if segue.identifier == "accountAdded" {
            
        }
    }
}

extension AccountForm: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        AccountTableView.reloadData()
    }
}
