//
//  extension.swift
//  NIBM COVID19
//
//  Created by Mohamed Minsaf on 8/22/20.
//  Copyright © 2020 Mohamed Minsaf. All rights reserved.
//

import Foundation
import UIKit




extension UITextField {
    func textField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField{
        let txtFields = UITextField()
        txtFields.borderStyle = .none
        txtFields.font = UIFont.systemFont(ofSize: 16)
        txtFields.textColor = .white
        txtFields.keyboardAppearance = .dark
        txtFields.isSecureTextEntry = isSecureTextEntry
        txtFields.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        return txtFields
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?=nil,
                left: NSLayoutXAxisAnchor?=nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                               right: NSLayoutXAxisAnchor? = nil,
                             paddingTop: CGFloat = 0,
                              paddingLeft: CGFloat = 0,
                              paddingBottom: CGFloat = 0,
                               paddingRight: CGFloat = 0,
                               height: CGFloat? = nil,
            width: CGFloat? = nil
    ){
     translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
                  leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
                }
          if let right = right {
                    rightAnchor.constraint(equalTo: right, constant: -paddingTop).isActive = true
               }
        
              if let bottom = bottom {
                  bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
              }
        
              if let width = width {
                  widthAnchor.constraint(equalToConstant: width).isActive = true
              }
        
               if let height = height {
                   heightAnchor.constraint(equalToConstant: height).isActive = true
               }
        
    }
    func centerX(inView view: UIView) {
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       }
    func centerY(inView view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func inputContainerView( textField: UITextField) -> UIView {
        let view = UIView()
        
     view.addSubview(textField)
        textField.centerY(inView: view)
        textField.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    

}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha!)
    }
    
    static let backgroundColor = rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = rgb(red: 17, green: 154, blue: 237)
}
