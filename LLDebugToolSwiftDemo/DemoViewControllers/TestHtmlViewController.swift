//
//  TestHtmlViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by admin10000 on 2019/11/22.
//

import UIKit

import LLDebugTool

class TestHtmlViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.html", comment: "")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = NSLocalizedString("show.html", comment: "")
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = NSLocalizedString("show.custom.html", comment: "")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.testHtml()
        } else if (indexPath.row == 1) {
            self.testCustomHtmlViewController()
        }
    }
    
    // MARK: - Action
    private func testHtml() {
        if LLConfig.shared().htmlViewControllerProvider != nil {
            LLConfig.shared().htmlViewControllerProvider = nil
        }
        LLDebugTool.shared().execute(.html)
    }

    private func testCustomHtmlViewController() {
        if LLConfig.shared().htmlViewControllerProvider == nil {
            LLConfig.shared().htmlViewControllerProvider = { (url) -> UIViewController in
                let vc = CustomWebViewController()
                vc.url = url
                return vc
            }
        }
        LLDebugTool.shared().execute(.html)
    }

}
