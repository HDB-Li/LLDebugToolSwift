//
//  CustomWebViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by admin10000 on 2019/11/22.
//

import UIKit

import WebKit

class CustomWebViewController: UIViewController {

    public var url : String?
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = NSLocalizedString("custom.html.view.controller", comment: "")
        return label
    }()
    
    private lazy var webView : WKWebView = {
        let view = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.webView)
        
        self.webView.load(URLRequest(url: URL(string: self.url != nil ? self.url! : "https://github.com/HDB-Li/LLDebugTool")!))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navigationBarHeight = self.navigationController!.navigationBar.frame.height + self.navigationController!.navigationBar.frame.origin.y
        self.titleLabel.frame = CGRect(x: 0, y: navigationBarHeight, width: self.view.frame.width, height: 100)
        self.webView.frame = CGRect(x: 0, y: navigationBarHeight + 100, width: self.view.frame.width, height: self.view.frame.height - 100 - navigationBarHeight)
    }

}
