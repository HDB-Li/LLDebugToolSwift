//
//  TestColorStyleViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class TestColorStyleViewController: BaseTestViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.color.style", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleHack\""
            cell.accessoryType = LLConfig.shared().colorStyle == .hack ? .checkmark : .none
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleSimple\""
            cell.accessoryType = LLConfig.shared().colorStyle == .simple ? .checkmark : .none
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleSystem\""
            cell.accessoryType = LLConfig.shared().colorStyle == .system ? .checkmark : .none
        } else if (indexPath.row == 3) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleGrass\""
            cell.accessoryType = LLConfig.shared().colorStyle == .grass ? .checkmark : .none
        } else if (indexPath.row == 4) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleHomebrew\""
            cell.accessoryType = LLConfig.shared().colorStyle == .homebrew ? .checkmark : .none
        } else if (indexPath.row == 5) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleManPage\""
            cell.accessoryType = LLConfig.shared().colorStyle == .manPage ? .checkmark : .none
        } else if (indexPath.row == 6) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleNovel\""
            cell.accessoryType = LLConfig.shared().colorStyle == .novel ? .checkmark : .none
        } else if (indexPath.row == 7) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleOcean\""
            cell.accessoryType = LLConfig.shared().colorStyle == .ocean ? .checkmark : .none
        } else if (indexPath.row == 8) {
            cell.textLabel?.text = "Use \"LLConfigColorStylePro\""
            cell.accessoryType = LLConfig.shared().colorStyle == .pro ? .checkmark : .none
        } else if (indexPath.row == 9) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleRedSands\""
            cell.accessoryType = LLConfig.shared().colorStyle == .redSands ? .checkmark : .none
        } else if (indexPath.row == 10) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleSilverAerogel\""
            cell.accessoryType = LLConfig.shared().colorStyle == .silverAerogel ? .checkmark : .none
        } else if (indexPath.row == 11) {
            cell.textLabel?.text = "Use \"LLConfigColorStyleSolidColors\""
            cell.accessoryType = LLConfig.shared().colorStyle == .solidColors ? .checkmark : .none
        } else if (indexPath.row == 12) {
            cell.textLabel?.text = "Use \"[[LLConfig sharedConfig] configBackgroundColor:[UIColor orangeColor] primaryColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault]\""
            cell.accessoryType = LLConfig.shared().colorStyle == .custom ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testHackColorStyle()
        } else if (indexPath.row == 1) {
            self.testSimpleColorSytle()
        } else if (indexPath.row == 2) {
            self.testSystemColorStyle()
        } else if (indexPath.row == 3) {
            self.testCustomColorConfig()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    private func testHackColorStyle() {
        LLConfig.shared().colorStyle = .hack
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testSimpleColorSytle() {
        LLConfig.shared().colorStyle = .simple
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testSystemColorStyle() {
        LLConfig.shared().colorStyle = .system
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testGrassColorStyle() {
        LLConfig.shared().colorStyle = .grass
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testHomebrewColorStyle() {
        LLConfig.shared().colorStyle = .homebrew
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testManPageColorStyle() {
        LLConfig.shared().colorStyle = .manPage
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testNovelColorStyle() {
        LLConfig.shared().colorStyle = .novel
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testOceanColorStyle() {
        LLConfig.shared().colorStyle = .ocean
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testProColorStyle() {
        LLConfig.shared().colorStyle = .pro
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testRedSandsColorStyle() {
        LLConfig.shared().colorStyle = .redSands
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testSilverAerogelColorStyle() {
        LLConfig.shared().colorStyle = .silverAerogel
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testSolidColorsColorStyle() {
        LLConfig.shared().colorStyle = .solidColors
        LLDebugTool.shared().execute(.setting)
    }
    
    private func testCustomColorConfig() {
        LLConfig.shared().configPrimaryColor(.white, backgroundColor: .orange, statusBarStyle: .default)
        LLDebugTool.shared().execute(.setting)
    }
    
}
