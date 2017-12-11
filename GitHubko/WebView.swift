//
//  WebView.swift
//  GitHubko
//
//  Created by D&M on 22.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit

class WebView: UIViewController {

    var webView: UIWebView!
    var url: URL!

    convenience init(url: URL!) {
        self.init()
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: UIScreen.main.bounds)
        view.addSubview(webView)
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
