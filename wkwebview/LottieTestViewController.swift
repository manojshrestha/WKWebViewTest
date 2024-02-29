import UIKit
import Lottie

class LottieTestViewController: UIPageViewController {

    // Array containing filenames of local Lottie files
    let lottieData = ["Lottie1","Lottie2","Lottie3","Lottie4","Lottie6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        // Start with the first page
        if let firstViewController = viewControllerAtIndex(0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Method to create a view controller for a given index
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard index >= 0 && index < lottieData.count else {
            return nil
        }
        let lottieViewController = LottiePageViewController()
        lottieViewController.lottieFilename = lottieData[index]
        lottieViewController.pageIndex = index
        return lottieViewController
    }
}

extension LottieTestViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let lottieViewController = viewController as? LottiePageViewController,
           let index = lottieViewController.pageIndex, index > 0 {
            return viewControllerAtIndex(index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let lottieViewController = viewController as? LottiePageViewController,
           let index = lottieViewController.pageIndex, index < lottieData.count - 1 {
            return viewControllerAtIndex(index + 1)
        }
        self.navigationController?.popViewController(animated: true)
        return nil
    }
}

class LottiePageViewController: UIViewController {
    
    var lottieFilename: String?
    var pageIndex: Int?
    var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Create AnimationView
        animationView = LottieAnimationView()
        animationView.contentMode = .scaleAspectFit
        self.view.backgroundColor = .white
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Load Lottie animation from local JSON file
        if let lottieFilename = lottieFilename {
            if let animation = LottieAnimation.named(lottieFilename) {
                animationView.animation = animation
                animationView.loopMode = .loop
                animationView.play()
            }
        }
    }
}
