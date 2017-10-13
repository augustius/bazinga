//
//  Account.swift
//  Bazinga!
//
//  Created by augustius cokroe on 13/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import Foundation
import CoreData

extension AccountDB
{
    func getData() -> [AccountDB]
    {
        let emptyPredicate = NSPredicate()
        return getData(withPredicate: emptyPredicate)
    }
    
    func getData(withPredicate predicate:NSPredicate) -> [AccountDB]
    {
        var allAccount:[AccountDB] = []
        if let managedContext = appDelegate?.persistentContainer.viewContext
        {
            do
            {
                let request:NSFetchRequest<AccountDB> = AccountDB.fetchRequest()
                request.predicate = predicate
                allAccount = try managedContext.fetch(request)
            }
            catch let error as NSError
            {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return allAccount
    }
    
    func getChildAccount() -> [SubaccountDB]
    {
        var allSubAccount:[SubaccountDB] = []
        
        
        
        return allSubAccount
    }
}
