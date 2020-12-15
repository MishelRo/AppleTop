//
//  WebViewController.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    
    var url = ""
    
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadingPage(url: url)
    }
    
    func downloadingPage(url: String) {
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        webview.load(request)
    }
    
}
