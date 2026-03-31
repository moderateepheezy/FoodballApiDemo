//  CustomViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.

import UIKit
import SwiftUI

/// A UIViewController that loads a custom UIView as its .view
/// the typed view can be accessed via the .customView property
///
/// It also enforces a specific view model be provided upon creation
/// which can be accessed via the .viewModel property
class CustomViewController<ViewType: UIView, ViewModelType>: UIViewController {
    /// Provides typed access to the view controllers custom view
    var customView: ViewType { return self.view as! ViewType }
    
    /// Provides typed access to the view controllers view model
    let viewModel: ViewModelType
    
    // MARK - Lifecycle
    required init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    init() {
        fatalError("Must be initialised using init(viewModel:)")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Must be initialised using init(viewModel:)")
    }
    override func loadView() {
        self.view = ViewType(frame: UIScreen.main.bounds)
        // Setup for SwiftUI integration can be added here if necessary
        let swiftUIView = YourSwiftUIView() // Replace with your actual SwiftUI View
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.frame = self.view.bounds
        addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}