//
//  IntroViewController.swift
//  pagingPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

final class IntroViewController: UIViewController, IntroViewDelegate {

    // MARK: - View
    private lazy var introView: IntroView = {
        let view = IntroView()
        view.delegate = self
        return view
    }()
    
    // MARK: - ViewModel
    private let viewModel: IntroViewModel
    
    // MARK: - Init
    init(viewModel: IntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This object should not be used on xib or storyboard.")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    private func configureView() {
        view = introView
        title = "Intro"
    }
    
    // MARK: - View delegate
    func didTapIntroButton() {
        let nextViewController = HomeBuilder().build()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
