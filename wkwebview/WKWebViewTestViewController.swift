//
//  ViewController.swift
//  WKWebViewTest
//
//  Created by Shrestha, Manoj |
//

import UIKit
import WebKit

class WKWebViewTestViewController: UIViewController, UITextFieldDelegate,WKNavigationDelegate{
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var  webView1 : WKWebView!
    
    //QR Code - some issue
    //var url = "https://webqr.com/"
    //var url = "https://qrcodescan.in"
    
    
    //Working
    //var url = "https://websdk-label-demo.scandit.com/"
    
    
    var url = "https://google.com/news"
    
    //jQuery plugin - scan and follow - working
    //var url = "https://mauntrelio.github.io/demos/qrcode-reader/"
    
    
    //html5 javascript - working
    //var url = "https://blog.minhazav.dev/research/html5-qrcode.html"
    
    
    
    
    //var url = "https://www.the-qrcode-generator.com/scan"
    //var url =  "https://pwascanit.com/"
    //var url =    "https://minishlink.github.io/pwa-qr-code-scanner/"
    //var url =  "https://www.dynamsoft.com/barcode-reader/sdk-javascript/"
    
    //face tracking
    //var url = "https://www.visagetechnologies.com/HTML5/latest/Samples/ShowcaseDemo/ShowcaseDemo.html"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WKWebView Test"
        self.navigationController?.navigationBar.isHidden = false
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
                
        webView1 = WKWebView(frame: CGRectMake(0, 0, 0, 0), configuration: configuration)
        webView1.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView1)
        
        NSLayoutConstraint.activate([
            webView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            webView1.topAnchor.constraint(equalTo: containerView.topAnchor),
            webView1.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Do any additional setup after loading the view.
        
        // webView1 = WKWebView(frame: webView1.frame, configuration: configuration)
        webView1.load(URLRequest(url: URL(string: url)!))
        txtUrl.text = url
        txtUrl.delegate = self
        webView1.navigationDelegate = self
    }
    
    
    @IBAction func btnGoClicked(_ sender: UIButton) {
        let url = txtUrl.text ?? ""
        webView1.load(URLRequest(url: URL(string: url)!))
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("hit entered")
        if (string as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        }
        btnGoClicked(UIButton())
        txtUrl.resignFirstResponder()
        return false
    }
    
    @IBAction func gpsClicked(_ sender: UIButton) {
        url = "https://www.w3schools.com/html/html5_geolocation.asp"
        webView1.load(URLRequest(url: URL(string: url)!))
    }
    
    @IBAction func cameraClicked(_ sender: UIButton) {
        url = "https://qrcodescan.in"
        webView1.load(URLRequest(url: URL(string: url)!))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("inside")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            self.txtUrl.text = urlStr
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.txtUrl.text = webView.url?.absoluteString
    }
}

