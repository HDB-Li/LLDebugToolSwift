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
    private var locationManager :CLLocationManager!
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LLDebugTool need time to start.
        sleep(1)
        doSomeActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Primary
    private func doSomeActions() {
        requestPhotoAuthorization()
        requestLocationAuthorization()
        doSandboxIfNeeded()
        doCrashIfNeeded()
        doNetwork()
        doLog()
    }
    
    private func requestPhotoAuthorization() {
        // Try to get album permission, and if possible, screenshots are stored in the album at the same time.
        PHPhotoLibrary.requestAuthorization { (status) in
            
        }
    }
    
    private func requestLocationAuthorization() {
        // Try to get location permission, and if possible, mock location will get your current location.
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func doCrashIfNeeded() {
        if UserDefaults.standard.bool(forKey: "openCrash") {
            UserDefaults.standard.set(false, forKey: "openCrash")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                LLDebugTool.shared().execute(.crash)
            }
        }
    }
    
    private func doSandboxIfNeeded() {
        DispatchQueue.global().async {
            let extensions = ["gif", "html", "jpg", "json", "md", "mp3", "mp4", "pdf", "plist", "png", "txt"]
            for ext in extensions {
                self.copyFileWithExtensionIfNeeded(ext: ext)
            }
        }
    }
    
    private func copyFileWithExtensionIfNeeded(ext : String) {
        if ext.count == 0 {
            return
        }
        let manager = FileManager.default
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let targetPath = documentsPath + "/LLDebugTool." + ext
        if !manager.fileExists(atPath: targetPath) {
            guard let path = Bundle.main.path(forResource: "LLDebugTool", ofType: ext) else { return }
            do {
                try manager.copyItem(atPath: path, toPath: targetPath)
            } catch {
                print("Copy resource failed")
            }
        }
    }
    
    private func doNetwork() {
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
        var htmlRequest = URLRequest(url: URL(string: "https://www.baidu.com")!)
        htmlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: htmlRequest) { (data, response, error) in
            
        }
        dataTask.resume()
    }
    
    private func doLog() {
        // Log.
        // NSLocalizedString is used for multiple languages.
        // You can just use as LLog.log(@"What you want to pring").
        LLog.log(message: NSLocalizedString("initial.log", comment: ""))
        
        LLog.alertLog(message: NSLocalizedString("initial.log", comment: ""), event: "Demo")
    }
    
    // MARK: - Actions
    private func testColorConfig() {
        let vc = TestColorStyleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testWindowStyle() {
        let vc = TestWindowStyleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testNetwork() {
        let vc = TestNetworkViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testLog() {
        let vc = TestLogViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testCrash() {
        let vc = TestCrashViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testAppInfo() {
        LLDebugTool.shared().execute(.appInfo)
    }
    
    private func testSandbox() {
        LLDebugTool.shared().execute(.sandbox)
    }
    
    private func testScreenshot() {
        LLDebugTool.shared().execute(.convenientScreenshot)
    }
    
    private func testHierarchy() {
        let vc = TestHierarchyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testMagnifier() {
        LLDebugTool.shared().execute(.magnifier)
    }
    
    private func testRuler() {
        LLDebugTool.shared().execute(.ruler)
    }
    
    private func testWidgetBorder() {
        LLDebugTool.shared().execute(.widgetBorder)
    }
    
    private func testHtml() {
        let vc = TestHtmlViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testLocation() {
        let vc = TestLocationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func testShortCut() {
        let vc = TestShortCutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
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
                case .grass:
                    cell.detailTextLabel?.text = "LLConfigColorStyleGrass"
                case .homebrew:
                    cell.detailTextLabel?.text = "LLConfigColorStyleHomebrew"
                case .manPage:
                    cell.detailTextLabel?.text = "LLConfigColorStyleManPage"
                case .novel:
                    cell.detailTextLabel?.text = "LLConfigColorStyleNovel"
                case .ocean:
                    cell.detailTextLabel?.text = "LLConfigColorStyleOcean"
                case .pro:
                    cell.detailTextLabel?.text = "LLConfigColorStylePro"
                case .redSands:
                    cell.detailTextLabel?.text = "LLConfigColorStyleRedSands"
                case .silverAerogel:
                    cell.detailTextLabel?.text = "LLConfigColorStyleSilverAerogel"
                case .solidColors:
                    cell.detailTextLabel?.text = "LLConfigColorStyleSolidColors"
                case .custom:
                    cell.detailTextLabel?.text = "LLConfigColorStyleCustom"
                }
            } else if (indexPath.row == 1) {
                cell.textLabel?.text = NSLocalizedString("test.window.style", comment: "")
                cell.accessoryType = .disclosureIndicator
                switch (LLConfig.shared().entryWindowStyle) {
                case .ball:
                    cell.detailTextLabel?.text = "LLConfigEntryWindowStyleBall"
                case .title:
                    cell.detailTextLabel?.text = "LLConfigEntryWindowStyleTitle"
                case .leading:
                    cell.detailTextLabel?.text = "LLConfigEntryWindowStyleLeading"
                case .trailing:
                    cell.detailTextLabel?.text = "LLConfigEntryWindowStyleTrailing"
                case .powerBar:
                    cell.detailTextLabel?.text = "LLConfigWindowPowerBar"
                case .netBar:
                    cell.detailTextLabel?.text = "LLConfigWindowNetBar"
                }
            }
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = NSLocalizedString("test.network.request", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 2) {
            cell.textLabel?.text = NSLocalizedString("test.log", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 3) {
            cell.textLabel?.text = NSLocalizedString("test.crash", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 4) {
            cell.textLabel?.text = NSLocalizedString("app.info", comment: "")
        } else if (indexPath.section == 5) {
            cell.textLabel?.text = NSLocalizedString("sandbox.info", comment: "")
        } else if (indexPath.section == 6) {
            cell.textLabel?.text = NSLocalizedString("test.screenshot", comment: "")
        } else if (indexPath.section == 7) {
            cell.textLabel?.text = NSLocalizedString("test.hierarchy", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 8) {
            cell.textLabel?.text = NSLocalizedString("test.magnifier", comment: "")
        } else if (indexPath.section == 9) {
            cell.textLabel?.text = NSLocalizedString("test.ruler", comment: "")
        } else if (indexPath.section == 10) {
            cell.textLabel?.text = NSLocalizedString("test.widget.border", comment: "")
        } else if (indexPath.section == 11) {
            cell.textLabel?.text = NSLocalizedString("test.html", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 12) {
            cell.textLabel?.text = NSLocalizedString("test.location", comment: "")
            cell.accessoryType = .disclosureIndicator
        } else if (indexPath.section == 13) {
            cell.textLabel?.text = NSLocalizedString("test.short.cut", comment: "")
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                testColorConfig()
            } else if (indexPath.row == 1) {
                testWindowStyle()
            }
        } else if (indexPath.section == 1) {
            testNetwork()
        } else if (indexPath.section == 2) {
            testLog()
        } else if (indexPath.section == 3) {
            testCrash()
        } else if (indexPath.section == 4) {
            testAppInfo()
        } else if (indexPath.section == 5) {
            testSandbox()
        } else if (indexPath.section == 6) {
            testScreenshot()
        } else if (indexPath.section == 7) {
            testHierarchy()
        } else if (indexPath.section == 8) {
            testMagnifier()
        } else if (indexPath.section == 9) {
            testRuler()
        } else if (indexPath.section == 10) {
            testWidgetBorder()
        } else if (indexPath.section == 11) {
            testHtml()
        } else if (indexPath.section == 12) {
            testLocation()
        } else if (indexPath.section == 13) {
            testShortCut()
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "LLConfig"
        } else if (section == 1) {
            return "Network Request"
        } else if (section == 2) {
            return "Log"
        } else if (section == 3) {
            return "Crash"
        } else if (section == 4) {
            return "App Info"
        } else if (section == 5) {
            return "Sandbox Info"
        } else if (section == 6) {
            return "Screen Shot"
        } else if (section == 7) {
            return "Hierarchy"
        } else if (section == 8) {
            return "Magnifier"
        } else if (section == 9) {
            return "Ruler"
        } else if (section == 10) {
            return "Widget Border"
        } else if (section == 11) {
            return "Html"
        } else if (section == 12) {
            return "Location"
        } else if (section == 13) {
            return "Short Cut"
        }
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

