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

	var groupId		= -1
	var groupName	= ""
	var newFlg		= true
	var compareNum	= 1

	let SCREEN_SIZE		= UIScreen.main.bounds.size

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
		let items: Results<CompareItemRealm>
		let contents: Results<CompareContentsRealm>
		if( !newFlg ) {
			let realm = try! Realm()
			items = realm.objects(CompareItemRealm.self).filter("groupID="+String(groupId))
			groupName = String(items.first!.groupName)
			contents = realm.objects(CompareContentsRealm.self).filter("groupID="+String(groupId))
			//update contents num
			if( contents.count > 1 ) {
				compareNum = contents.count
			}
		}

		// calc width
		let itemWidth = (SCREEN_SIZE.width - 20) / 6
		var eachWidth = (SCREEN_SIZE.width - 20) - itemWidth
		if( compareNum < 5 ) {
			eachWidth = (SCREEN_SIZE.width - 20 - itemWidth) / CGFloat(compareNum)
		} else {
			eachWidth = (SCREEN_SIZE.width - 20 - itemWidth) / 5
		}

		// gourp name
		if( newFlg ) {
			self.groupNameTF.text = "新しい比較"
		} else {
			self.groupNameTF.text = groupName
		}
		self.groupNameTF.textAlignment = NSTextAlignment.center
		self.groupNameTF.font = UIFont.systemFont(ofSize: 25.0)
		self.view.addSubview(self.groupNameTF)
		self.groupNameTF.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(60)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(75)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(75)
		}
		self.groupNameTF.delegate = self

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
