//
//  TestHierarchyViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by admin10000 on 2019/9/29.
//

import UIKit

class TestHierarchyViewController: BaseTestViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("hierarchy.info", comment: "")
        self.tableView.tableHeaderView = tableHeaderView

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(testHierarchy))
        
        testHierarchy()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row]
        var view = cell.viewWithTag(100)
        view?.removeFromSuperview()
        view = self.getCellView(indexPath.row)
        if let view = view {
            cell.contentView.addSubview(view)
        }
        return cell
    }
    
    private func getCellView(_ index: Int) -> UIView? {
        var view : UIView?
        if (index == 0) {
            view = UIView()
            view?.backgroundColor = .groupTableViewBackground
        } else if (index == 1) {
            let label = UILabel()
            label.text = "Label"
            view = label
        } else if (index == 2) {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "AppIcon")
            imageView.contentMode = .scaleAspectFit
            view = imageView
        } else if (index == 3) {
            let btn = UIButton(type: .system)
            btn.setTitle("Button", for: .normal)
            btn.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
            view = btn
        } else if (index == 4) {
            let textField = UITextField()
            textField.placeholder = "Text Field"
            view = textField
        } else if (index == 5)  {
            let control = UISegmentedControl(items: ["1", "2"])
            control.selectedSegmentIndex = 0
            view = control
        } else if (index == 6) {
            let slider = UISlider()
            view = slider
        } else if (index == 7) {
            let swit = UISwitch()
            view = swit
        } else if (index == 8) {
            let activity = UIActivityIndicatorView()
            activity.startAnimating()
            view = activity
        } else if (index == 9) {
            let progress = UIProgressView()
            view = progress
        } else if (index == 10) {
            let control = UIPageControl()
            control.numberOfPages = 3
            control.currentPage = 1
            view = control
        } else if (index == 11) {
            let stepper = UIStepper()
            view = stepper
        } else if (index == 12) {
            let scrollView = UIScrollView()
            view = scrollView
        } else if (index == 13) {
            let tableView = UITableView()
            view = tableView
        } else if (index == 14) {
            let cell = UITableViewCell()
            view = cell
        } else if (index == 15) {
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
            view = collectionView
        } else if (index == 16) {
            let reusableView = UICollectionReusableView()
            view = reusableView
        } else if (index == 17) {
            let textView = UITextView()
            view = textView
        } else if (index == 18) {
            let picker = UIDatePicker()
            view = picker
        } else if (index == 19) {
            let picker = UIPickerView()
            view = picker
        } else if (index == 20) {
            let bar = UINavigationBar()
            view = bar
        } else if (index == 21) {
            let bar = UIToolbar()
            view = bar
        } else if (index == 22) {
            let bar = UITabBar()
            view = bar
        } else if (index == 23) {
            let bar = UISearchBar()
            view = bar
        }
        view?.frame = CGRect(x: 10 * 2 + UIScreen.main.bounds.size.width / 2.0, y: 5, width: UIScreen.main.bounds.size.width - 10 * 3 - UIScreen.main.bounds.size.width / 2.0, height: 44 - 5 * 2)
        view?.backgroundColor = .groupTableViewBackground
        view?.tag = 100
        return view
    }

    private lazy var tableHeaderView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 55))
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 40, y: 10, width: view.frame.size.width - 40 * 2, height: view.frame.size.height - 10 * 2)
        btn.setTitle(NSLocalizedString("test.hierarchy", comment: "") , for: .normal)
        btn.addTarget(self, action: #selector(testHierarchy), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = btn.tintColor.cgColor
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        view.addSubview(btn)
        return view
    }()
    
    @objc private func testHierarchy() {
        
    }
    
    @objc private func touchUpInside(_ sender: UIButton) {
        
    }
    
    private lazy var dataArray : [String] = {
        return ["UIView", "UILabel", "UIImageView", "UIButton", "UITextField", "UISegmentedControl","UISlider", "UISwitch","UIActivityIndicatorView", "UIProgressView", "UIPageControl", "UIStepper", "UIScrollView", "UITableView", "UITableViewCell", "UICollectionView", "UICollectionReusableView", "UITextView", "UIDatePicker", "UIPickerView", "UINavigationBar", "UIToolbar", "UITabBar", "UISearchBar"]
    }()
}
