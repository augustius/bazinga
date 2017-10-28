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
    var allAccount:NSFetchedResultsController<AccountDB> = NSFetchedResultsController()
//    var tempData:[AccountDB] = []{
//        didSet{
//            DispatchQueue.main.async {
//                self.AccountTableView.reloadData()
//            }
//        }
//    }
    
    //MARK:View cycle
    override func viewDidLoad() {
        
        // get account data
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            do
            {
                let accountRequest:NSFetchRequest<AccountDB> = AccountDB.fetchRequest()
                
//                accountRequest.fetchBatchSize = 20
                
                let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
                accountRequest.sortDescriptors = [sortDescriptor]
                
                let fetchedResultController = NSFetchedResultsController(fetchRequest: accountRequest,
                                                                         managedObjectContext: managedContext,
                                                                         sectionNameKeyPath: nil,
                                                                         cacheName: nil)
                fetchedResultController.delegate = self
                try fetchedResultController.performFetch()

                allAccount = fetchedResultController
            }
            catch let error as NSError
            {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
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
                let selectedAccount = sender as? AccountDB
                else { print("error on \(#function), \(#line) "); return}
            
            dvc.currentAccount = selectedAccount
            dvc.usage = .edit

//            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//            childContext.parent = coreDataStack.mainContext
//
//            let newJournalEntry = JournalEntry(context: childContext)
//
//            detailViewController.journalEntry = newJournalEntry
//            detailViewController.context = childContext

        }
    }
    
    @IBAction func unwindToAccountForm(segue: UIStoryboardSegue) {
        if segue.identifier == "accountAdded" {
            
//            guard
//                let svc = segue.source as? AddAccountForm
//                else { print("error on \(#function), \(#line) "); return}
//
//            if let managedContext = appDelegate?.persistentContainer.viewContext
//            {
//                let newAccountEntry = AccountDB(context: managedContext)
//                newAccountEntry.name = svc.currentAccountName
//
//                managedContext.perform {
//                    do{
//                        try managedContext.save()
//                    } catch let error as NSError {
//                        fatalError("Error: \(error.localizedDescription)")
//                    }
//                }
//            }

            
//            tempData.append(svc.currentAccountName)
            

        }
    }
}

extension AccountForm: NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        AccountTableView.reloadData()
    }
}
