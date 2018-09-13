//
//  BaseTestViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class BaseTestViewController: UITableViewController {

    public var cellID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellID = NSStringFromClass(self.classForCoder)
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reusableCell = tableView.dequeueReusableCell(withIdentifier: self.cellID)
        if (reusableCell == nil) {
            reusableCell = UITableViewCell(style: .subtitle, reuseIdentifier: self.cellID)
            reusableCell?.selectionStyle = .none
        }
        let cell = reusableCell!
        cell.textLabel?.text = nil
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = nil
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessoryType = .none
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
