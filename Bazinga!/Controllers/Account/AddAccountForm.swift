//
//  AddAccountForm.swift
//  Bazinga!
//
//  Created by augustius cokroe on 28/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import Foundation
import UIKit

enum AddAccountFormUsage{
    case add, edit
}

class AddAccountForm:UIViewController
{
    @IBOutlet var button: UIButton!
    var currentAccountName = ""
    var usage:AddAccountFormUsage = .add
    var currentAccount:Account!
    
    override func viewDidAppear(_ animated: Bool) {
        switch usage {
        case .add:
            break
        case .edit:
            currentAccountName = currentAccount.name ?? ""
            button.setTitle("update", for: .normal)
            button.backgroundColor = UIColor.red
            break
        }
    }
    
    
    @IBAction func buttonPressed(){
        switch usage {
        case .add:
            
            if let managedContext = appDelegate?.persistentContainer.viewContext
            {
                currentAccount = Account(context: managedContext)
                currentAccount.name = currentAccountName
                
                managedContext.perform {
                    do{
                        try managedContext.save()
                    } catch let error as NSError {
                        fatalError("Error: \(error.localizedDescription)")
                    }
                }
            }
            
//            performSegue(withIdentifier: "accountAdded", sender: self)
        case .edit:
            
            if let managedContext = appDelegate?.persistentContainer.viewContext
            {
//                managedContext.delete(currentAccount)
                currentAccount.name = currentAccountName
            }
            
            
        }
        
        performSegue(withIdentifier: "accountEdited", sender: self)
        
    }
}

// MARK: - segue method
extension AddAccountForm
{
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "accountAdded" || identifier == "accountEdited"
        {
            return currentAccountName != ""
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "embededAddAccountCell"
        {
            guard
                let dvc = segue.destination as? AddAccountTableView
                else { print("error on \(#function), \(#line) "); return}
            
            dvc.delegate = self
            dvc.currentAccount = currentAccount
        }
    }
}

// MARK: - AddAccountCellUpdated delegate
extension AddAccountForm:AddAccountCellDelegate
{
    func cellUpdated(view: AddAccountTableView) {
        
        currentAccountName = view.accountName.text ?? ""
    }
}
