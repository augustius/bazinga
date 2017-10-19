//
//  AccountForm.swift
//  Bazinga!
//
//  Created by augustius cokroe on 13/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import UIKit
import Foundation

class AccountForm: UIViewController{
    
    @IBAction func addAccount(_ sender: UIBarButtonItem)
    {
        
    }
    
    
    
}

// MARK: UITableViewDelegate method
extension AccountForm: UITableViewDataSource,UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        
        return cell
    }
    
}
