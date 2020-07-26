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

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "比較リスト"

		// background color
		self.view.backgroundColor = UIColor.white

		// 表示用データ取得
		let realm = try! Realm()
		let allItems	= realm.objects(HikakuItemRealm.self)
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
