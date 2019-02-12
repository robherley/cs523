//
//  ViewController.swift
//  WebBrowser
//
//  Created by Robert Herley on 2/11/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        urlTextField.autocorrectionType = UITextAutocorrectionType.no
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadUrl(url: "https://apple.com")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadUrl(url: urlTextField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func loadUrl(url urlString : String){
        let url : URL
        if(urlString.hasPrefix("http://") || urlString.hasPrefix("https://")){
            url = URL(string: urlString)!
        } else {
            url = URL(string: "http://" + urlString)!
        }
        let urlReq = URLRequest(url: url)
        webView.load(urlReq)
        urlTextField.text = url.absoluteString
    }
    
    @IBAction func navigate(_ sender: UIButton) {
        if(sender.tag == 0){
            // Back
            if(webView.canGoBack){
                webView.goBack()
            }
        } else {
            // Forward
            if(webView.canGoForward){
                webView.goForward()
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        urlTextField.text = webView.url?.absoluteString
    }
    
}

