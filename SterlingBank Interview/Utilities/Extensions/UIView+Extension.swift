//
//  UIView+Extension.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

extension UIView {
    
    func center(in view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fill(_ view: UIView, offset: CGFloat = 0.0) {
        leftAnchor.align(to: view.leftAnchor, offset: offset)
        rightAnchor.align(to: view.rightAnchor, offset: -offset)
        topAnchor.align(to: view.topAnchor, offset: offset)
        bottomAnchor.align(to: view.bottomAnchor, offset: -offset)
    }
}
extension NSLayoutDimension {
    func align(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, multiplier: multiplier, constant: offset).isActive = true
    }
    func equal(to value: CGFloat) {
        constraint(equalToConstant: value).isActive = true
    }
}
extension NSLayoutXAxisAnchor {
    func align(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
extension NSLayoutYAxisAnchor {
    func align(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
