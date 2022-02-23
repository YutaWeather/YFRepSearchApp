//
//  UIViewController+Ext.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import UIKit

extension UIViewController {

    func presentAlertVC(title:String,message:String,buttonTitle:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

}
