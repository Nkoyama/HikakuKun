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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	// データ表示用TabelView
	var hikakuListTable	= UITableView()
	var displayList: [String] = []
	var groupIdList: [Int] = []

	let addNewHikakuBtn		= UIButton()
	let howToUseBtn			= UIButton()

	var count = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "比較リスト"

		// background color
		self.view.backgroundColor = UIColor.white

		// 表示用データ取得
		displayList = []
		groupIdList = []
		let realm = try! Realm(configuration: config)
		let allItems = realm.objects(CompareItemRealm.self)
		for item in allItems {
			var displayText = item.groupName
			let contents = realm.objects(CompareContentsRealm.self).filter("groupId="+String(item.groupId))
			var i = 0
			for content in contents {
				if( i == 0 ) {
					displayText = displayText + "  :  " + content.name
				} else {
					displayText = displayText + ", " + content.name
				}
				i += 1
			}
			displayList.append(displayText)
			groupIdList.append(item.groupId)
			count += 1
		}

		// 取得したデータ表示
		self.hikakuListTable.dataSource = self
		self.view.addSubview(self.hikakuListTable)
		self.hikakuListTable.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(0)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(0)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(100)
		}
		self.hikakuListTable.dataSource = self
		self.hikakuListTable.delegate = self

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

		// how-to-use button
		self.howToUseBtn.setTitle("？", for: .normal)
		self.howToUseBtn.setTitleColor(UIColor.blue, for: .normal)
		self.howToUseBtn.backgroundColor = UIColor.clear
		self.howToUseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 35.0)
		self.howToUseBtn.titleLabel?.adjustsFontSizeToFitWidth = true
		self.howToUseBtn.titleLabel?.baselineAdjustment = .alignCenters
		self.howToUseBtn.layer.borderColor = UIColor.blue.cgColor
		self.howToUseBtn.layer.borderWidth = 1.0
		self.howToUseBtn.layer.cornerRadius = 25.0
		self.view.addSubview(self.howToUseBtn)
		self.howToUseBtn.addTarget(self,
								   action: #selector(self.howToUseBtnDidTap(_:)),
								   for: .touchUpInside)
		self.howToUseBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(90)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(140)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(70)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(20)
		}
	}

	/// add new hikaku button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func addNewHikakuBtnDidTap(_ sender: UIButton) {
		let nextVC = CompareMainVC()
		let newGroupId = Int(CompareItemRealm().getMaxGroupId()) + 1
		nextVC.groupId = newGroupId
		nextVC.rowNum = 1
		nextVC.callBack = { () in
			self.callBack()
		}
		self.present(nextVC,
					 animated: true,
					 completion: nil)
	}

	/// how-to-use button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func howToUseBtnDidTap(_ sender: UIButton) {
		let nextVC = HowToUseVC()
		self.present(nextVC,
					 animated: true,
					 completion: nil)
	}

	/// 画面遷移から戻ってきたときに実行する関数
	func callBack() {
		// 画面再読み込み
		self.loadView()
		self.viewDidLoad()
		self.hikakuListTable.reloadData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		// safe area の width, height を取得
		let SCREEN_WIDTH = UIScreen.main.bounds.size.width
		let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
		var topPadding:CGFloat = 0
		var bottomPadding:CGFloat = 0
		var leftPadding:CGFloat = 0
		var rightPadding:CGFloat = 0
		if #available(iOS 11.0, *) {
			// viewDidLayoutSubviewsではSafeAreaの取得ができている
			topPadding = self.view.safeAreaInsets.top
			bottomPadding = self.view.safeAreaInsets.bottom
			leftPadding = self.view.safeAreaInsets.left
			rightPadding = self.view.safeAreaInsets.right
		}
		SAFE_AREA_WIDTH = SCREEN_WIDTH - leftPadding - rightPadding
		SAFE_AREA_HEIGHT = SCREEN_HEIGHT - topPadding - bottomPadding
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return displayList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = displayList[indexPath.row]
		return cell
	}
	
	/// リストタップ時の画面遷移
	/// - Parameters:
	///   - tableView: tabelView
	///   - indexPath: IndexPath
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let groupId = groupIdList[indexPath.row]
		let nextVC = CompareMainVC()
		nextVC.groupId = groupId
		var idNum = 1
		do {
			//行数判定
			let items = try CompareItemRealm().getItems(groupId: groupId)
			let contents = try CompareContentsRealm().getContentsList(groupId: groupId)
			let contents_id1 = contents.filter("id = 1").first
			let contents_id2 = contents.filter("id = 2").first
			let contents_id3 = contents.filter("id = 3").first
			let contents_id4 = contents.filter("id = 4").first
			if( items.first?.item2 != "" ) {
				idNum = 2
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content2 != "" ) {
						idNum = 2
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content2 != "" ) {
						idNum = 2
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content2 != "" ) {
						idNum = 2
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content2 != "" ) {
						idNum = 2
					}
				}
			}
			if( items.first?.item3 != "" ) {
				idNum = 3
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content3 != "" ) {
						idNum = 3
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content3 != "" ) {
						idNum = 3
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content3 != "" ) {
						idNum = 3
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content3 != "" ) {
						idNum = 3
					}
				}
			}
			if( items.first?.item4 != "" ) {
				idNum = 4
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content4 != "" ) {
						idNum = 4
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content4 != "" ) {
						idNum = 4
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content4 != "" ) {
						idNum = 4
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content4 != "" ) {
						idNum = 4
					}
				}
			}
			if( items.first?.item5 != "" ) {
				idNum = 5
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content5 != "" ) {
						idNum = 5
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content5 != "" ) {
						idNum = 5
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content5 != "" ) {
						idNum = 5
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content5 != "" ) {
						idNum = 5
					}
				}
			}
			if( items.first?.item6 != "" ) {
				idNum = 6
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content6 != "" ) {
						idNum = 6
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content6 != "" ) {
						idNum = 6
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content6 != "" ) {
						idNum = 6
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content6 != "" ) {
						idNum = 6
					}
				}
			}
			if( items.first?.item7 != "" ) {
				idNum = 7
			} else {
				if( contents_id1 != nil ) {
					if( contents_id1?.content7 != "" ) {
						idNum = 7
					}
				}
				if( contents_id2 != nil ) {
					if( contents_id2?.content7 != "" ) {
						idNum = 7
					}
				}
				if( contents_id3 != nil ) {
					if( contents_id3?.content7 != "" ) {
						idNum = 7
					}
				}
				if( contents_id4 != nil ) {
					if( contents_id4?.content7 != "" ) {
						idNum = 7
					}
				}
			}
		} catch {
			print("error")
		}
		nextVC.rowNum = idNum
		nextVC.callBack = { () in
			self.callBack()
		}
		self.present(nextVC,
					 animated: true,
					 completion: nil)
	}

	// リストをスワイプした際の削除処理
	func tableView(_ tableView: UITableView,
				   commit editingStyle: UITableViewCell.EditingStyle,
				   forRowAt indexPath: IndexPath) {
		/* define actions */
		// alert message：Yesボタン押下
		let yesAction = UIAlertAction(title: "Yes",
									  style: .default,
									  handler:{ (action: UIAlertAction!) -> Void in
			//画面上の削除
			self.displayList.remove(at: indexPath.row)
			self.hikakuListTable.deleteRows(at: [indexPath], with: .automatic)
			//データ削除
			let deleteGroupId = self.groupIdList[indexPath.row]
			do {
				let realm = try Realm(configuration: config)
				let deleteItem = try CompareItemRealm().getItems(groupId: deleteGroupId)
				let deleteContents = try CompareContentsRealm().getContentsList(groupId: deleteGroupId)
				try realm.write {
					realm.delete(deleteItem)
					realm.delete(deleteContents)
				}
			} catch {
				print("error")
			}
		})
		// alert message：Noボタン押下
		let noAction = UIAlertAction(title: "No",
									 style: .default,
									 handler:{(action: UIAlertAction!) -> Void in})
		let alert = UIAlertController(title: "",
									  message: "該当データを削除します。よろしいですか？",
									  preferredStyle: .alert)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		present(alert, animated: true, completion: nil)
	}
}
