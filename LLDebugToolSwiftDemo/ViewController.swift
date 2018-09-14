//
//  ViewController.swift
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugToolSwift)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

// Request
import LLDebugTool

// For demo.
import Photos
import Alamofire

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Try to get album permission, and if possible, screenshots are stored in the album at the same time.
        PHPhotoLibrary.requestAuthorization { (status) in
            
        }
        
        // LLDebugTool need time to start.
        sleep(1)
        
        if UserDefaults.standard.bool(forKey: "openCrash") {
            UserDefaults.standard.set(false, forKey: "openCrash")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                LLDebugTool.shared().showDebugViewController(with: 2)
            }
        }
        
        //Network Request
        var urlRequest = URLRequest(url: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525346881086&di=b234c66c82427034962131d20e9f6b56&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011cf15548caf50000019ae9c5c728.jpg%402o.jpg")!)
        urlRequest.httpMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: OperationQueue()) {[weak self] (response, data, connectionError) in
            if connectionError == nil && data != nil {
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self?.imgView.image = image
                }
            }
        }

        // Json Response
        Alamofire.request("http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?&format=json&appid=379020&bk_key=%E7%81%AB%E5%BD%B1%E5%BF%8D%E8%80%85&bk_length=600").responseJSON { (response) in

        }
        
        //NSURLSession
        var htmlRequest = URLRequest(url: URL(string: "https://cocoapods.org/pods/LLDebugTool")!)
        htmlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: htmlRequest) { (data, response, error) in
            // Not important. Just check to see if the current Demo version is consistent with the latest version.
            // 只是检查一下当前Demo版本和最新版本是否一致，不一致就提示一下新版本。
            if error == nil && data != nil {
                let htmlString = String(data: data!, encoding: String.Encoding.utf8)
                let array = htmlString?.components(separatedBy: "http://cocoadocs.org/docsets/LLDebugToolSwift/")
                if array != nil && array!.count > 2 {
                    let str = array![1]
                    let array2 = str.components(separatedBy: "/preview.png")
                    if array2.count >= 2 {
                        let newVersion = array2[0]
                        if newVersion.components(separatedBy: ".").count == 3 {
                            if LLDebugTool.shared().version.compare(newVersion) == .orderedAscending {
                                let vc = UIAlertController(title: "Note", message: String(format: "%@\nNew Version : %@\nCurrent Version : %@", arguments: [NSLocalizedString("new.version", comment: ""),newVersion,LLDebugTool.shared().version]), preferredStyle: .alert)
                                let action = UIAlertAction(title: "I known", style: .default, handler: nil)
                                vc.addAction(action)
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
        dataTask.resume()
        
        // Log.
        // NSLocalizedString is used for multiple languages.
        // You can just use as LLog.log(@"What you want to pring").
        LLog.log(message: NSLocalizedString("initial.log", comment: ""))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions
    private func testAppInfo() {
        LLDebugTool.shared().showDebugViewController(with: 3)
    }
    
    private func testSandbox() {
        LLDebugTool.shared().showDebugViewController(with: 4)
    }
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return 0
        }
        if section == 3 {
            return 1
        }
        if section == 4 {
            return 1
        }
        if section == 5 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reusableCell = tableView.dequeueReusableCell(withIdentifier: self.cellID)
        if reusableCell == nil {
            reusableCell = UITableViewCell(style: .subtitle, reuseIdentifier: self.cellID)
            reusableCell?.selectionStyle = .none
        }
        let cell = reusableCell!
        cell.textLabel?.text = nil
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = nil
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessoryType = .none
        if (indexPath.section == 0) {
            cell.textLabel?.text = NSLocalizedString("test.network.request", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = NSLocalizedString("test.log", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 2) {
            cell.textLabel?.text = NSLocalizedString("test.crash", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 3) {
            cell.textLabel?.text = NSLocalizedString("app.info", comment: "")
        } else if (indexPath.section == 4) {
            cell.textLabel?.text = NSLocalizedString("sandbox.info", comment: "")
        } else if (indexPath.section == 5) {
            if (indexPath.row == 0) {
                cell.textLabel?.text = NSLocalizedString("test.color.style", comment: "")
                cell.accessoryType = .disclosureIndicator
                switch (LLConfig.shared().colorStyle) {
                case .hack:
                    cell.detailTextLabel?.text = "LLConfigColorStyleHack"
                case .simple:
                    cell.detailTextLabel?.text = "LLConfigColorStyleSimple"
                case .system:
                    cell.detailTextLabel?.text = "LLConfigColorStyleSystem"
                case .custom:
                    cell.detailTextLabel?.text = "LLConfigColorStyleCustom"
                }
            } else if (indexPath.row == 1) {
                cell.textLabel?.text = NSLocalizedString("test.window.style", comment: "")
                cell.accessoryType = .disclosureIndicator
                switch (LLConfig.shared().windowStyle) {
                case .suspensionBall:
                    cell.detailTextLabel?.text = "LLConfigWindowSuspensionBall"
                case .powerBar:
                    cell.detailTextLabel?.text = "LLConfigWindowPowerBar"
                case .netBar:
                    cell.detailTextLabel?.text = "LLConfigWindowNetBar"
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let vc = TestNetworkViewController(style: .grouped)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 1) {
            let vc = TestLogViewController(style: .grouped)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 2) {
            LLTool.toastMessage("A little bug, Fix soon.")
            return
            let vc = TestCrashViewController(style: .grouped)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.section == 3) {
            self.testAppInfo()
        } else if (indexPath.section == 4) {
            self.testSandbox()
        } else if (indexPath.section == 5) {
            if (indexPath.row == 0) {
                let vc = TestColorStyleViewController(style: .grouped)
                self.navigationController?.pushViewController(vc, animated: true)
            } else if (indexPath.row == 1) {
                let vc = TestWindowStyleViewController(style: .grouped)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Network Request"
        } else if (section == 1) {
            return "Log"
        } else if (section == 2) {
//            return "Crash"
        } else if (section == 3) {
            return "App Info"
        } else if (section == 4) {
            return "Sandbox Info"
        } else if (section == 5) {
            return "LLConfig"
        }
        return nil;
    }
}

