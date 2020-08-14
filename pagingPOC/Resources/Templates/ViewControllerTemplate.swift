/*
 import UIKit

 final class IntroViewController: UIViewController {
     
     // MARK: - View
     private lazy var introView: IntroView = {
         let view = IntroView()
 //        view.delegate = self
         return view
     }()
     
     // MARK: - ViewModel
     private let viewModel: IntroViewModel
     
     // MARK: - Init
     init(viewModel: IntroViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
 //        viewModel.presenter = self
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
     
 }
 */
