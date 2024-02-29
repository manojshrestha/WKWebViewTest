import UIKit

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    let options = ["WKWebView Test", "Lottie Test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Testing ground"
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.accessoryType = .disclosureIndicator // Add disclosure indicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
            if let webViewTestVC = storyboard.instantiateViewController(withIdentifier: "WKWebViewTestViewController") as? WKWebViewTestViewController {
                navigationController?.pushViewController(webViewTestVC, animated: true)
            }
        case 1:
            let lottieTestVC = LottieTestViewController()
            navigationController?.pushViewController(lottieTestVC, animated: true)
        default:
            break
        }
    }
}
