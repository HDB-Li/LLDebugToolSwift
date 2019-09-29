//
//  TestWindowStyleViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class TestWindowStyleViewController: BaseTestViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.window.style", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if #available(iOS 13.0, *) {
            return 4
        } else {
            return 6
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Use \"Ball\""
            cell.accessoryType = LLConfig.shared().entryWindowStyle == .ball ? .checkmark : .none
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = "Use \"Title\""
            cell.accessoryType = LLConfig.shared().entryWindowStyle == .title ? .checkmark : .none
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = "Use \"Leading\""
            cell.accessoryType = LLConfig.shared().entryWindowStyle == .leading ? .checkmark : .none
        } else if (indexPath.row == 3) {
            cell.textLabel?.text = "Use \"Trailing\""
            cell.accessoryType = LLConfig.shared().entryWindowStyle == .trailing ? .checkmark : .none
        } else {
            if #available(iOS 13.0, *) {
                if (indexPath.row == 4) {
                    cell.textLabel?.text = "Use \"NetBar\""
                    cell.accessoryType = LLConfig.shared().entryWindowStyle == .netBar ? .checkmark : .none
                } else if (indexPath.row == 5) {
                    cell.textLabel?.text = "Use \"PowerBar\""
                    cell.accessoryType = LLConfig.shared().entryWindowStyle == .powerBar ? .checkmark : .none
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            testBallWindowStyle()
        } else if (indexPath.row == 1) {
            testTitleWindowStyle()
        } else if (indexPath.row == 2) {
            testLeadingWindowStyle()
        } else if (indexPath.row == 3) {
            testTrailingWindowStyle()
        } else if (indexPath.row == 4) {
            testNetBarWindowStyle()
        } else if (indexPath.row == 5) {
            testPowerBarWindowStyle()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testBallWindowStyle() {
        LLConfig.shared().entryWindowStyle = .ball
    }
    
    func testTitleWindowStyle() {
        LLConfig.shared().entryWindowStyle = .title
    }
    
    func testLeadingWindowStyle() {
        LLConfig.shared().entryWindowStyle = .leading
    }
    
    func testTrailingWindowStyle() {
        LLConfig.shared().entryWindowStyle = .trailing
    }
    
    func testPowerBarWindowStyle() {
        if #available(iOS 13.0, *) {
            LLConfig.shared().entryWindowStyle = .powerBar
        } else {
            LLConfig.shared().entryWindowStyle = .powerBar
        }
    }
    
    func testNetBarWindowStyle() {
        if #available(iOS 13.0, *) {
            LLConfig.shared().entryWindowStyle = .netBar
        } else {
            LLConfig.shared().entryWindowStyle = .netBar
        }
    }
    
}
