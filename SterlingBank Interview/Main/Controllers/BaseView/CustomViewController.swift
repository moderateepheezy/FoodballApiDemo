//
//  CustomViewController.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/25/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

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
    }
}

