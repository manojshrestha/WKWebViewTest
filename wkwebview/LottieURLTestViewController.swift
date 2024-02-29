import UIKit
import Lottie

class LottiePaginationTestViewController: UIPageViewController {
    
    // Array containing filenames of local Lottie files
    var lottieURLs = [URL(string: "https://lottie.host/cb7a7361-8be1-4503-bccf-0b29ef36908e/nTeiLv3Vfo.json")!,
                              URL(string: "https://lottie.host/0acbbdf0-655b-4bcc-8e57-eb18f6e1a453/gDgKPGkWOt.json")!]
    
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
        guard index >= 0 && index < lottieURLs.count else {
            return nil
        }
        print("Page index: \(index)")
        
        //        let lottieViewController = UIViewController()
        let lottieViewController = LottieURLTestViewController()
        lottieViewController.animationURL = lottieURLs[index]
        lottieViewController.pageIndex = index
        return lottieViewController
    }
}

extension LottiePaginationTestViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let lottieViewController = viewController as? LottieURLTestViewController,
           let index = lottieViewController.pageIndex, index > 0 {
            return viewControllerAtIndex(index - 1)
        }
        self.navigationController?.popViewController(animated: true)
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let lottieViewController = viewController as? LottieURLTestViewController,
           let index = lottieViewController.pageIndex, index < lottieURLs.count - 1 {
            return viewControllerAtIndex(index + 1)
        }
        self.navigationController?.popViewController(animated: true)
        return nil
    }
}




class LottieURLTestViewController: UIViewController {
    
    var animationURL = URL(string: "https://lottie.host/0acbbdf0-655b-4bcc-8e57-eb18f6e1a453/gDgKPGkWOt.json")! // Replace with your own animation URL
    
    var animationView: LottieAnimationView!
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        LottieAnimation.loadedFrom(url: animationURL) { (animation) in
            self.animationView.animation = animation
            self.animationView.loopMode = .loop
            self.animationView.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationView.stop()
    }
}
