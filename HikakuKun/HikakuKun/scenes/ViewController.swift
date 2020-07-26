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
	var allGroupNames: [String] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "比較リスト"

		// background color
		self.view.backgroundColor = UIColor.white

		// 表示用データ取得
		let realm = try! Realm()
		let allItems = realm.objects(HikakuItemRealm.self)
		for item in allItems {
			allGroupNames.append(item.groupName)
		}

		// 取得したデータ表示
		hikakuListTable.frame = view.bounds
		hikakuListTable.dataSource = self
		view.addSubview(hikakuListTable)
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allGroupNames.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = allGroupNames[indexPath.row]
		return cell
	}
}
