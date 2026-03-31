// BaseView.swift
// SterlingBank Interview
//
// Created by Afees Lawal on 6/25/19.
// Copyright © 2019 Afees Lawal. All rights reserved.

import UIKit

class BaseView: UIView {
    
override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // Setup for SwiftUI integration can be added here
        let swiftUIView = YourSwiftUIView() // Replace with your actual SwiftUI View
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.frame = self.bounds
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}