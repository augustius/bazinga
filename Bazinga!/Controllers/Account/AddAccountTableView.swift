//
//  AddAccountTableView.swift
//  Bazinga!
//
//  Created by augustius cokroe on 28/10/2017.
//  Copyright © 2017 augustius cokroe. All rights reserved.
//

import Foundation
import UIKit

protocol AddAccountCellDelegate: class {
    func cellUpdated(view: AddAccountTableView)
}

class AddAccountTableView:UITableViewController
{
    //MARK: IBOutlet
    @IBOutlet var accountName: UITextField!
    var currentAccount:Account!
    weak var delegate: AddAccountCellDelegate?
    
    override func viewDidLoad() {
//        accountName.text == currentAccount.name ?? ""
    }
    
    @IBAction func clearAccountName() {
        accountName.text = ""
    }
}

//UITextfield Delegate
extension AddAccountTableView:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        delegate?.cellUpdated(view: self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        delegate?.cellUpdated(view: self)
        accountName.resignFirstResponder()
        return true
    }
    
}
