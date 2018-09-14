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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Use \"LLConfigWindowSuspensionBall\""
            cell.accessoryType = LLConfig.shared().windowStyle == .suspensionBall ? .checkmark : .none
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = "Use \"LLConfigWindowPowerBar\""
            cell.accessoryType = LLConfig.shared().windowStyle == .powerBar ? .checkmark : .none
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = "Use \"LLConfigWindowNetBar\""
            cell.accessoryType = LLConfig.shared().windowStyle == .netBar ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testSuspensionBallWindowStyle()
        } else if (indexPath.row == 1) {
            self.testPowerBarWindowStyle()
        } else if (indexPath.row == 2) {
            self.testNetBarWindowStyle()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testSuspensionBallWindowStyle() {
        LLConfig.shared().windowStyle = .suspensionBall
    }
    
    func testPowerBarWindowStyle() {
        LLConfig.shared().windowStyle = .powerBar
    }
    
    func testNetBarWindowStyle() {
        LLConfig.shared().windowStyle = .netBar
    }

}
