import UIKit

class LottieURLInputViewController: UIViewController {
    
    // Define UI components
    let swipeLabel = UILabel()
    let firstURLTextField = UITextField()
    let secondURLTextField = UITextField()
    let nextButton = UIButton()
    let clearButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up view
        view.backgroundColor = .white
        
        
        
        // Add swipe label
             swipeLabel.text = "Swipe to view next Lottie URL"
             swipeLabel.textAlignment = .center
             swipeLabel.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(swipeLabel)
        
        
        // Add first URL text field
        firstURLTextField.placeholder = "Enter first URL"
        firstURLTextField.borderStyle = .roundedRect
        firstURLTextField.translatesAutoresizingMaskIntoConstraints = false
        firstURLTextField.text = "https://lottie.host/cb7a7361-8be1-4503-bccf-0b29ef36908e/nTeiLv3Vfo.json"
        view.addSubview(firstURLTextField)
        
        // Add second URL text field
        secondURLTextField.placeholder = "Enter second URL"
        secondURLTextField.borderStyle = .roundedRect
        secondURLTextField.translatesAutoresizingMaskIntoConstraints = false
        secondURLTextField.text = "https://lottie.host/0acbbdf0-655b-4bcc-8e57-eb18f6e1a453/gDgKPGkWOt.json"
        view.addSubview(secondURLTextField)
        
        // Add next button
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.layer.cornerRadius = 5
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        // Add clear button
        clearButton.setTitle("Clear", for: .normal)
        clearButton.backgroundColor = .red
        clearButton.layer.cornerRadius = 5
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            swipeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            swipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swipeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            firstURLTextField.topAnchor.constraint(equalTo: swipeLabel.bottomAnchor, constant: 20),
            firstURLTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstURLTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstURLTextField.heightAnchor.constraint(equalToConstant: 40),
            
            secondURLTextField.topAnchor.constraint(equalTo: firstURLTextField.bottomAnchor, constant: 20),
            secondURLTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondURLTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondURLTextField.heightAnchor.constraint(equalToConstant: 40),
            
            nextButton.topAnchor.constraint(equalTo: secondURLTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            
            clearButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 100),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func nextButtonTapped() {
        // Retrieve URLs from text fields
        guard let firstURLString = firstURLTextField.text,
              let secondURLString = secondURLTextField.text,
              !(firstURLString.isEmpty && secondURLString.isEmpty) else {
            // Handle invalid or empty URLs
            if firstURLTextField.text?.isEmpty == true && secondURLTextField.text?.isEmpty == true {
                showAlert(message: "Please enter at least one URL.")
            }
            return
        }
        
        // Create array of URLs
        var urls: [URL] = []
        if let firstURL = URL(string: firstURLString) {
            urls.append(firstURL)
            
        }
        if let secondURL = URL(string: secondURLString) {
            urls.append(secondURL)
        }

        // Use the array of URLs as needed
        print("Array of URLs: \(urls)")
        
        let nextVC = LottiePaginationTestViewController()
        nextVC.lottieURLs = urls
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func clearButtonTapped() {
        // Clear text fields
        firstURLTextField.text = ""
        secondURLTextField.text = ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
