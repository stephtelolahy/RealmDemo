//
//  UIViewControllerExtension.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/17/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentInputDialog(title: String,
                            textFieldPlaceHolder:String,
                            confirmActionTitle: String,
                            completion: @escaping (_ text: String) -> Void) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = textFieldPlaceHolder
        }
        
        //the confirm action taking the input
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default) { (_) in
            
            //getting the input value from user
            if let name = alertController.textFields?[0].text, !name.isEmpty {
                completion(name)
            }
        }
        alertController.addAction(confirmAction)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
}
