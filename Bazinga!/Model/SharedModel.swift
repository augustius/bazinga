//
//  SharedModel.swift
//  Bazinga!
//
//  Created by augustius cokroe on 30/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import Foundation
import CoreData

class SharedModel
{
    private init() {}
    
    static let shared = SharedModel()
    
    func updateContext() -> Bool
    {
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            return saveContext(managedContext)
        }
        return false
    }
    
    private func saveContext(_ managedContext:NSManagedObjectContext) -> Bool
    {
        var isSuccess = true
        managedContext.perform
        {
            do
            {
                try managedContext.save()
            }
            catch let error as NSError
            {
                isSuccess = false
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        return isSuccess
    }
}

// MARK: - Account
extension SharedModel
{
    func getAllAccount(delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<Account>
    {
        var allAccount:NSFetchedResultsController<Account> = NSFetchedResultsController()
        
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            do
            {
                let accountRequest:NSFetchRequest<Account> = Account.fetchRequest()
                //accountRequest.fetchBatchSize = 20
                
                let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
                accountRequest.sortDescriptors = [sortDescriptor]
                
                let fetchedResultController = NSFetchedResultsController(fetchRequest: accountRequest,
                                                                         managedObjectContext: managedContext,
                                                                         sectionNameKeyPath: nil,
                                                                         cacheName: nil)
                fetchedResultController.delegate = delegate
                try fetchedResultController.performFetch()
                
                allAccount = fetchedResultController
            }
            catch let error as NSError
            {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return allAccount
    }
    
    func deleteAccount(_ account:Account) -> Bool
    {
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            managedContext.delete(account)
            return saveContext(managedContext)
        }
        return false
    }
    
    func addAccount(_ name:String) -> Bool
    {
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            let currentAccount  = Account(context: managedContext)
            currentAccount.name = name
            
            return saveContext(managedContext)
        }
        return false
    }
    
}

