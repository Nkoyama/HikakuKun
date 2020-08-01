//
//  CompareMainVC.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class CompareMainVC: UIViewController, UITextFieldDelegate {

	let backBtn		= UIButton()
	let groupNameTF	= UITextField()
	let saveBtn		= UIButton()
	let nameTF_1	= UITextField()
	let nameTF_2	= UITextField()
	let nameTF_3	= UITextField()
	let nameTF_4	= UITextField()
	let nameTF_5	= UITextField()

	let itemsSV		= UIScrollView()
	let itemTF_01	= UITextField()
	let itemTF_02	= UITextField()
	let itemTF_03	= UITextField()
	let itemTF_04	= UITextField()
	let itemTF_05	= UITextField()
	let itemTF_06	= UITextField()
	let itemTF_07	= UITextField()
	let itemTF_08	= UITextField()
	let itemTF_09	= UITextField()
	let itemTF_10	= UITextField()

	var groupId		= -1
	var compareNum	= 1

	let SCREEN_SIZE			= UIScreen.main.bounds.size
	let TITLE_H				= 50
	let NAME_H				= 30
	let BOTTOM_H			= 50
	let ITEM_H				= 30
	let RIGHT_W: CGFloat	= 30.0

	//クロージャを保持するためのプロパティ
	var callBack: (() -> Void)?

	override func viewDidLoad() {
		// hidden navigation bar
		self.navigationController?.setNavigationBarHidden(true,
														  animated:false)

		// background color
		self.view.backgroundColor = UIColor.white

		// back button
		self.backBtn.setTitle("< back", for: .normal)
		self.backBtn.setTitleColor(UIColor.blue, for: .normal)
		self.backBtn.backgroundColor = UIColor.clear
		self.backBtn.layer.borderColor = UIColor.clear.cgColor
		self.view.addSubview(self.backBtn)
		self.backBtn.addTarget(self,
							   action: #selector(self.backBtnDidTap(_:)),
							   for: .touchUpInside)
		self.backBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(10)
		}

		// save button
		self.saveBtn.setTitle("保存", for: .normal)
		self.saveBtn.setTitleColor(UIColor.blue, for: .normal)
		self.saveBtn.backgroundColor = UIColor.clear
		self.saveBtn.layer.borderColor = UIColor.clear.cgColor
		self.view.addSubview(self.saveBtn)
		self.saveBtn.addTarget(self,
							   action: #selector(self.saveBtnDidTap(_:)),
							   for: .touchUpInside)
		self.saveBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(10)
		}

		/* get items and contents */
		var items: Results<CompareItemRealm>!
		var contents: Results<CompareContentsRealm>!
		do{
			items = try CompareItemRealm().getItems(groupId: String(groupId))
			contents = try CompareContentsRealm().getContentsList(groupId: String(groupId))
			//update contents num
			if( contents.count > 1 ) {
				compareNum = contents.count
			}
		} catch {
			print("error")
		}

		// calc width
		let itemWidth = (SCREEN_SIZE.width - RIGHT_W) / 6
		var eachWidth = (SCREEN_SIZE.width - itemWidth) / 5
		if( compareNum <= 2 ) {
			eachWidth = (SCREEN_SIZE.width - RIGHT_W - itemWidth) / 2
		} else if( compareNum < 5 ) {
			eachWidth = (SCREEN_SIZE.width - RIGHT_W - itemWidth) / CGFloat(compareNum)
		}

		// gourp name
		if( items.count > 0 ) {
			self.groupNameTF.text = items.first?.groupName
		} else {
			self.groupNameTF.placeholder = "タイトル"
		}
		self.groupNameTF.textAlignment = NSTextAlignment.center
		self.groupNameTF.font = UIFont.systemFont(ofSize: 25.0)
		self.view.addSubview(self.groupNameTF)
		self.groupNameTF.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(75)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(75)
		}
		self.groupNameTF.delegate = self

		/* 比較対象名 */
		// 1
		if( contents.count > 0 ) {
			if( (contents.first?.name.count)! > 0 ) {
				self.nameTF_1.text = contents.first?.name
			} else {
				self.nameTF_1.placeholder = "比較対象名を入力"
			}
		} else {
			self.nameTF_1.placeholder = "比較対象名を入力"
		}
		self.nameTF_1.textAlignment = NSTextAlignment.center
		self.nameTF_1.adjustsFontSizeToFitWidth = true
		self.nameTF_1.backgroundColor = UIColor.init(red: 242/255,
													 green: 279/255,
													 blue: 61/255,
													 alpha: 0.5)
		self.nameTF_1.layer.borderColor = UIColor.black.cgColor
		self.nameTF_1.layer.borderWidth = 0.5
		self.view.addSubview(self.nameTF_1)
		self.nameTF_1.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + NAME_H)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(itemWidth)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(eachWidth + itemWidth)
		}
		self.nameTF_1.delegate = self

		// 2
		if( contents.count >= 2 ) {
			if( (contents.filter("id = %@", "1").first?.name.count)! > 0 ) {
				self.nameTF_2.text = contents.first?.name
			} else {
				self.nameTF_2.placeholder = "比較対象名を入力"
			}
		} else {
			self.nameTF_2.placeholder = "比較対象名を入力"
		}
		self.nameTF_2.textAlignment = NSTextAlignment.center
		self.nameTF_2.adjustsFontSizeToFitWidth = true
		self.nameTF_2.backgroundColor = UIColor.init(red: 242/255,
													 green: 279/255,
													 blue: 61/255,
													 alpha: 0.5)
		self.nameTF_2.layer.borderColor = UIColor.black.cgColor
		self.nameTF_2.layer.borderWidth = 0.5
		self.view.addSubview(self.nameTF_2)
		self.nameTF_2.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + NAME_H)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(eachWidth + itemWidth)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(2*eachWidth + itemWidth)
		}
		self.nameTF_2.delegate = self

		// 3~
		if( contents.count >= 3 ) {
			for nameNum in 3...contents.count {
				var nameTF = UITextField()
				switch nameNum {
					case 3:
						nameTF = self.nameTF_3
						if( (contents.filter("id = %@", "2").first?.name.count)! > 0 ) {
							nameTF.text = contents.first?.name
							self.view.addSubview(nameTF)
						} else {
							nameTF.placeholder = "比較対象名を入力"
						}
					case 4:
						nameTF = self.nameTF_4
						if( (contents.filter("id = %@", "3").first?.name.count)! > 0 ) {
							nameTF.text = contents.first?.name
							self.view.addSubview(nameTF)
						} else {
							nameTF.placeholder = "比較対象名を入力"
						}
					case 5:
						nameTF = self.nameTF_5
						if( (contents.filter("id = %@", "4").first?.name.count)! > 0 ) {
							nameTF.text = contents.first?.name
							self.view.addSubview(nameTF)
						} else {
							nameTF.placeholder = "比較対象名を入力"
						}
					default:
						break
				}
				nameTF.textAlignment = NSTextAlignment.center
				nameTF.adjustsFontSizeToFitWidth = true
				nameTF.backgroundColor = UIColor.init(red: 242/255,
													  green: 279/255,
													  blue: 61/255,
													  alpha: 0.5)
				nameTF.layer.borderColor = UIColor.black.cgColor
				nameTF.layer.borderWidth = 0.5
				nameTF.snp.makeConstraints{ (make) in
					make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
					make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
						.inset(TITLE_H + NAME_H)
					make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
						.inset(CGFloat(nameNum-1) * eachWidth + itemWidth)
					make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left)
						.inset(CGFloat(nameNum) * eachWidth + itemWidth)
				}
				nameTF.delegate = self
			}
		}

		/* items(scroll view) */
		// item name 1
		if( items.first != nil ) {
			if( (items.first?.item1.count)! > 0 ) {
				self.itemTF_01.text = items.first?.item1
			} else {
				self.itemTF_01.placeholder = "比較項目1"
			}
		} else {
			self.itemTF_01.placeholder = "比較項目1"
		}
		self.itemTF_01.layer.borderColor = UIColor.black.cgColor
		self.itemTF_01.layer.borderWidth = 0.5
		self.itemTF_01.adjustsFontSizeToFitWidth = true
		self.itemsSV.addSubview(self.itemTF_01)
		self.itemTF_01.snp.makeConstraints{ (make) in
			make.top.equalTo(self.itemsSV.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.itemsSV.safeAreaLayoutGuide.snp.top).inset(ITEM_H)
			make.left.equalToSuperview()
			make.right.equalTo(self.itemsSV.safeAreaLayoutGuide.snp.left).inset(itemWidth)
		}
		// item names 2~
		if( items.first != nil ) {
			for itemNum in 1..<10 {
				var itemNameTF = UITextField()
				switch itemNum {
					case 1:
						itemNameTF = itemTF_02
						if( (items.first?.item2.count)! > 0 ) {
							itemNameTF.text = items.first?.item2
							self.itemsSV.addSubview(itemNameTF)
						}
					case 2:
						itemNameTF = itemTF_03
						if( (items.first?.item3.count)! > 0 ) {
							itemNameTF.text = items.first?.item3
							self.itemsSV.addSubview(itemNameTF)
						}
					case 3:
						itemNameTF = itemTF_04
						if( (items.first?.item4.count)! > 0 ) {
							itemNameTF.text = items.first?.item4
							self.itemsSV.addSubview(itemNameTF)
						}
					case 4:
						itemNameTF = itemTF_05
						if( (items.first?.item5.count)! > 0 ) {
							itemNameTF.text = items.first?.item5
							self.itemsSV.addSubview(itemNameTF)
						}
					case 5:
						itemNameTF = itemTF_06
						if( (items.first?.item6.count)! > 0 ) {
							itemNameTF.text = items.first?.item6
							self.itemsSV.addSubview(itemNameTF)
						}
					case 6:
						itemNameTF = itemTF_07
						if( (items.first?.item7.count)! > 0 ) {
							itemNameTF.text = items.first?.item7
							self.itemsSV.addSubview(itemNameTF)
						}
					case 7:
						itemNameTF = itemTF_08
						if( (items.first?.item8.count)! > 0 ) {
							itemNameTF.text = items.first?.item8
							self.itemsSV.addSubview(itemNameTF)
						}
					case 8:
						itemNameTF = itemTF_09
						if( (items.first?.item9.count)! > 0 ) {
							itemNameTF.text = items.first?.item9
							self.itemsSV.addSubview(itemNameTF)
						}
					case 9:
						itemNameTF = itemTF_10
						if( (items.first?.item10.count)! > 0 ) {
							itemNameTF.text = items.first?.item10
							self.itemsSV.addSubview(itemNameTF)
						}
					default:
						break
				}
				itemNameTF.layer.borderColor = UIColor.black.cgColor
				itemNameTF.layer.borderWidth = 0.5
				itemNameTF.adjustsFontSizeToFitWidth = true
				itemNameTF.snp.makeConstraints{ (make) in
					make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(itemNum*ITEM_H)
					make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset((itemNum+1)*ITEM_H)
					make.left.equalToSuperview()
					make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(itemWidth)
				}
			}
		}

		self.view.addSubview(self.itemsSV)
		self.itemsSV.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + NAME_H)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(BOTTOM_H)
			make.left.equalToSuperview()
			if( contents.count >= 5 ) {
				make.right.equalToSuperview()
			} else {
				make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(RIGHT_W)
			}
		}
		/* items(scroll view) end */
	}

	/// back button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func backBtnDidTap(_ sender: UIButton) {
		/* define actions */
		// alert message：Yesボタン押下
		let yesAction = UIAlertAction(title: "Yes",
									  style: .default,
									  handler:{
										(action: UIAlertAction!) -> Void in
										// 現在の画面削除 & 親画面再描画
										self.dismiss(animated: true){
											self.callBack?()
										}
		})
		// alert message：Noボタン押下
		let noAction = UIAlertAction(title: "No",
									 style: .default,
									 handler:{(action: UIAlertAction!) -> Void in})
		let alert = UIAlertController(title: "",
									  message: "保存されていないデータはリセットされます。よろしいですか？",
									  preferredStyle: .alert)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		present(alert, animated: true, completion: nil)
	}
	
	/// save button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func saveBtnDidTap(_ sender: UIButton) {
		
	}

	/// TextField以外の部分をタッチした時の処理
	/// - Parameters:
	///   - touches: Set<UITouch>
	///   - event: UIEvent
	/// - Authors: Nozomi Koyama
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// close keyboard
		self.groupNameTF.resignFirstResponder()
		self.nameTF_1.resignFirstResponder()
		self.nameTF_2.resignFirstResponder()
		self.nameTF_3.resignFirstResponder()
		self.nameTF_4.resignFirstResponder()
		self.nameTF_5.resignFirstResponder()
	}

	/// returnキーが押された時にキーボードを閉じる
	/// - Parameter textField:
	/// - Returns: (boolean)
	/// - Authors: Nozomi Koyama
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// キーボードを閉じる
		textField.resignFirstResponder()
		keyWindow?.endEditing(true)
		return true
	}
}
