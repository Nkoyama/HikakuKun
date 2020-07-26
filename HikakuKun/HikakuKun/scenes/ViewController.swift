//
//  ViewController.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController {

	// データ表示用TabelView
	var hikakuListTable	= UITableView()
	var displayList: [String] = []

	let addNewHikakuBtn		= UIButton()

	var count = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "比較リスト"

		// background color
		self.view.backgroundColor = UIColor.white

		// 表示用データ取得
		let realm = try! Realm()
		let allItems = realm.objects(HikakuItemRealm.self)
		for item in allItems {
			var displayText = item.groupName
			let contents = realm.objects(HikakuContentsRealm.self).filter("groupID="+String(item.groupId))
			var i = 0
			for content in contents {
				if( i == 0 ) {
					displayText = displayText + "  : " + content.name
				} else {
					displayText = displayText + ", " + content.name
				}
				i += 1
			}
			displayList.append(displayText)
			count += 1
		}

		// 取得したデータ表示
		self.hikakuListTable.dataSource = self
		view.addSubview(self.hikakuListTable)
		self.hikakuListTable.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(0)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(0)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(100)
		}

		// add new hikaku button
		self.addNewHikakuBtn.setTitle("＋", for: .normal)
		self.addNewHikakuBtn.setTitleColor(UIColor.blue, for: .normal)
		self.addNewHikakuBtn.backgroundColor = UIColor.clear
		self.addNewHikakuBtn.titleLabel?.font = UIFont.systemFont(ofSize: 35.0)
		self.addNewHikakuBtn.titleLabel?.adjustsFontSizeToFitWidth = true
		self.addNewHikakuBtn.titleLabel?.baselineAdjustment = .alignCenters
		self.addNewHikakuBtn.layer.borderColor = UIColor.blue.cgColor
		self.addNewHikakuBtn.layer.borderWidth = 1.0
		self.addNewHikakuBtn.layer.cornerRadius = 25.0
		self.view.addSubview(self.addNewHikakuBtn)
		self.addNewHikakuBtn.addTarget(self,
									   action: #selector(self.addNewHikakuBtnDidTap(_:)),
									   for: .touchUpInside)
		self.addNewHikakuBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(70)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(70)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(20)
		}
	}

	/// add new hikaku button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func addNewHikakuBtnDidTap(_ sender: UIButton) {
		let nextVC = HikakuMainVC()
		let realm = try! Realm()
		var newGroupId: Int = 0
		if( count == 0 ){
			newGroupId = 0
		} else {
			let maxGroupId = realm.objects(HikakuItemRealm.self).sorted(byKeyPath: "groupId", ascending: false).first?.groupId
			newGroupId = Int(maxGroupId!) + 1
		}
		nextVC.groupId = newGroupId
		self.navigationController?.pushViewController(nextVC,
													  animated: true)
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return displayList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = displayList[indexPath.row]
		return cell
	}
}
