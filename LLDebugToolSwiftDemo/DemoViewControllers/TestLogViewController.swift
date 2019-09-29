//
//  TestLogViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class TestLogViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.log", comment: "")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = NSLocalizedString("insert.log", comment: "")
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = NSLocalizedString("insert.error.log", comment: "")
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = NSLocalizedString("insert.call.log", comment: "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testNormalLog()
        } else if (indexPath.row == 1) {
            self.testErrorLog()
        } else if (indexPath.row == 2) {
            self.testEventLog()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testNormalLog() {
        LLog.log(message: NSLocalizedString("normal.log.info", comment: ""))
        LLDebugTool.shared().execute(.log)
    }
    
    func testErrorLog() {
        LLog.errorLog(message: NSLocalizedString("error.log.info", comment: ""))
        LLDebugTool.shared().execute(.log)
    }
    
    func testEventLog() {
        LLog.errorLog(message: NSLocalizedString("call.log.info", comment: ""), event: NSLocalizedString("call", comment: ""))
        LLDebugTool.shared().execute(.log)
    }

}
