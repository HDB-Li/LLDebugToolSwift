//
//  TestCrashViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class TestCrashViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.crash", comment: "")
    }
    
    private func initNoteView() {
        let header = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byCharWrapping
        label.text = NSLocalizedString("crash.tip", comment: "")
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.size.width - 20, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 10, y: 10, width: size.width, height: size.height)
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: size.height + 20)
        header.addSubview(label)
        
        let footer = UIView()
        //1570 × 1050
        let imageViewWidth = UIScreen.main.bounds.size.width - 20
        let imageViewHeight = imageViewWidth * 1050.0 / 1570.0
        let tipHeight : CGFloat = 30
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "crash-1.jpg")
        imageView1.frame = CGRect(x: 10, y: 10, width: imageViewWidth, height: imageViewHeight)
        footer.addSubview(imageView1)
        
        let tip1 = UILabel()
        tip1.textAlignment = .center
        tip1.font = UIFont.systemFont(ofSize: 14)
        tip1.text = "Tip 1"
        tip1.frame = CGRect(x: 0, y: 10 + imageViewHeight, width: UIScreen.main.bounds.size.width, height: tipHeight)
        footer.addSubview(tip1)
        
        let imageView2 = UIImageView()
        imageView2.image = UIImage(named: "crash-2.jpg")
        imageView2.frame = CGRect(x: 10, y: 10 + imageViewHeight + tipHeight + 10, width: imageViewWidth, height: imageViewHeight)
        footer.addSubview(imageView2)
        
        let tip2 = UILabel()
        tip2.textAlignment = .center
        tip2.font = UIFont.systemFont(ofSize: 14)
        tip2.text = "Tip 2"
        tip2.frame = CGRect(x: 0, y: 10 + imageViewHeight + tipHeight + 10 + imageViewHeight, width: UIScreen.main.bounds.size.width, height: tipHeight)
        footer.addSubview(tip2)
        footer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 10 + imageViewHeight + tipHeight + 10 + imageViewHeight + tipHeight + 10)

        self.tableView.tableHeaderView = header
        self.tableView.tableFooterView = footer
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = NSLocalizedString("try.array.crash", comment: "")
            cell.detailTextLabel?.text = NSLocalizedString("crash.info", comment: "")
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = NSLocalizedString("try.pointer.crash", comment: "")
            cell.detailTextLabel?.text = NSLocalizedString("crash.info", comment: "")
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = NSLocalizedString("try.signal", comment: "")
            cell.detailTextLabel?.text = NSLocalizedString("signal.info", comment: "")
        } else if (indexPath.row == 3) {
            cell.textLabel?.text = NSLocalizedString("try.swift.signal", comment: "")
            cell.detailTextLabel?.text = NSLocalizedString("signal.info", comment: "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testArrayOutRangeCrash()
        } else if (indexPath.row == 1) {
            self.testPointErrorCrash()
        } else if (indexPath.row == 2) {
            self.testSignalCrash()
        } else if (indexPath.row == 3) {
            self.testSwiftOptionalCrash()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testArrayOutRangeCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        sleep(1)
        let array = ["a" , "b"]
        _ = array[3]
    }
    
    func testPointErrorCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        sleep(1)
        let a : NSObject = "dssdf" as NSObject
        _ = (a as! NSArray).firstObject
    }
    
    func testSignalCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        kill(0, SIGTRAP)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            LLDebugTool.shared().execute(.crash)
            UserDefaults.standard.set(false, forKey: "openCrash")
            UserDefaults.standard.synchronize()
        }
    }

    func testSwiftOptionalCrash() {
        let name : String? = nil
        print(name!)
    }
    
}
