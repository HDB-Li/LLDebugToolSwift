//
//  TestNetworkViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool
import Alamofire

class TestNetworkViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.network.request", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = NSLocalizedString("normal.network", comment: "")
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = NSLocalizedString("image.network", comment: "")
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = NSLocalizedString("HTML.network", comment: "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testNormalNetworkRequest()
        } else if (indexPath.row == 1) {
            self.testImageNetworkRequest()
        } else if (indexPath.row == 2) {
            self.testHTMLNetworkRequest()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testNormalNetworkRequest() {
        
        let url = "http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?&format=json&appid=379020&bk_key=%E7%81%AB%E5%BD%B1%E5%BF%8D%E8%80%85&bk_length=600"
        // Use Alamofire
        Alamofire.request(url).responseJSON { (response) in
            LLDebugTool.shared().showDebugViewController(with: 0)
        }
    }
    
    func testImageNetworkRequest() {
        //NSURLConnection
        var request = URLRequest(url: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346881086&di=b234c66c82427034962131d20e9f6b56&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011cf15548caf50000019ae9c5c728.jpg%402o.jpg")!)
        request.httpMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response, data, error) in
            LLDebugTool.shared().showDebugViewController(with: 0)
        }
    }
    
    func testHTMLNetworkRequest() {
        //NSURLSession
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            LLDebugTool.shared().showDebugViewController(with: 0)
        }
        dataTask.resume()
    }

}
