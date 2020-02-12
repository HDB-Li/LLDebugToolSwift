//
//  TestShortCutViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2020/2/12.
//

import UIKit

import LLDebugTool

class TestShortCutViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("test.short.cut", comment: "")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = NSLocalizedString("add.custom.short.cut", comment: "")
        } else if indexPath.row == 1 {
            cell.textLabel?.text = NSLocalizedString("add.custom.none.return.short.cut", comment: "")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            testCustomShortCut()
        } else if indexPath.row == 1 {
            testCustomShortCutWithNoneReturn()
        }
    }
    
    // MARK: - Action
    private func testCustomShortCut() {
        LLConfig.shared().registerShortCut(withName: "Toast date") { () -> String? in
            return Date().description
        }
        LLDebugTool.shared().execute(.shortCut)
    }
    
    private func testCustomShortCutWithNoneReturn() {
        LLConfig.shared().registerShortCut(withName: "Do anything") { () -> String? in
            print("You can do anything at here.")
            return nil
        }
        LLDebugTool.shared().execute(.shortCut)
    }
}
