//
//  extension.swift
//  NIBM COVID19
//
//  Created by Mohamed Minsaf on 8/22/20.
//  Copyright © 2020 Mohamed Minsaf. All rights reserved.
//

import Foundation
import UIKit

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
    
    
//    func anchor(top: NSLayoutYAxisAnchor? = nil,
//                left: NSLayoutXAxisAnchor? = nil,
//                bottom: NSLayoutYAxisAnchor? = nil,
//                right: NSLayoutXAxisAnchor? = nil,
//                paddingTop: CGFloat = 0,
//                paddingLeft: CGFloat = 0,
//                paddingBottom: CGFloat = 0,
//                paddingRight: CGFloat = 0,
//                height: CGFloat? = nil,
//                width: CGFloat? = nil
//    ) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
//        }
//
//        if let left = left {
//            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
//        }
//
//        if let right = right {
//            rightAnchor.constraint(equalTo: right, constant: -paddingTop).isActive = true
//        }
//
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
//        }
//
//        if let width = width {
//            widthAnchor.constraint(equalToConstant: width).isActive = true
//        }
//
//        if let height = height {
//            heightAnchor.constraint(equalToConstant: height).isActive = true
//        }
//
//    }
//
//    func centerX(inView view: UIView) {
//        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    }
}