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

	var groupId		= -1
	var compareNum	= 1

	let SCREEN_SIZE		= UIScreen.main.bounds.size
	let titleH			= 50
	let nameH			= 30

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
			print(items!)
			contents = try CompareContentsRealm().getContentsList(groupId: String(groupId))
			print(contents!)
			//update contents num
			if( contents.count > 1 ) {
				compareNum = contents.count
			}
		} catch {
			print("error")
		}

		// calc width
		let itemWidth = (SCREEN_SIZE.width - 30) / 6
		var eachWidth = (SCREEN_SIZE.width - 30) - itemWidth
		if( compareNum <= 2 ) {
			eachWidth = (SCREEN_SIZE.width - 30 - itemWidth) / 2
		} else if( compareNum < 5 ) {
			eachWidth = (SCREEN_SIZE.width - 30 - itemWidth) / CGFloat(compareNum)
		} else {
			eachWidth = (SCREEN_SIZE.width - 30 - itemWidth) / 5
		}

		// gourp name
		if( items.count > 0 ) {
			self.groupNameTF.text = items.first?.groupName
		} else {
			self.groupNameTF.text = "タイトル"
		}
		self.groupNameTF.textAlignment = NSTextAlignment.center
		self.groupNameTF.font = UIFont.systemFont(ofSize: 25.0)
		self.view.addSubview(self.groupNameTF)
		self.groupNameTF.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(0)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH)
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
				self.nameTF_1.text = "比較対象名を入力"
			}
		} else {
			self.nameTF_1.text = "比較対象名を入力"
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
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH + nameH)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(itemWidth)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(eachWidth + itemWidth)
		}
		self.nameTF_1.delegate = self

		// 2
		if( contents.count >= 2 ) {
			if( (contents.filter("id = %@", "1").first?.name.count)! > 0 ) {
				self.nameTF_2.text = contents.first?.name
			} else {
				self.nameTF_2.text = ""
			}
		} else {
			self.nameTF_2.text = ""
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
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH + nameH)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(eachWidth + itemWidth)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(2*eachWidth + itemWidth)
		}
		self.nameTF_2.delegate = self

		// 3以降
		if( contents.count >= 3 ) {
			let nameTF = UITextField()
			for colNum in 3...contents.count {
				let content = contents.filter("id = %@", String(colNum-1)).first
				if( (content?.name.count)! > 0 ) {
					nameTF.text = content?.name
				} else {
					nameTF.text = "新規比較対象"
				}
				nameTF.textAlignment = NSTextAlignment.center
				nameTF.adjustsFontSizeToFitWidth = true
				nameTF.backgroundColor = UIColor.init(red: 0/255,
													  green: 30/255,
													  blue: 90/255,
													  alpha: 0.5)
				nameTF.layer.borderColor = UIColor.black.cgColor
				nameTF.layer.borderWidth = 0.5
				self.view.addSubview(nameTF)
				nameTF.snp.makeConstraints{ (make) in
					make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH)
					make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(titleH + nameH)
					make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(CGFloat(colNum-1)*eachWidth + itemWidth)
					make.right.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(CGFloat((colNum))*eachWidth + itemWidth)
				}
				nameTF.delegate = self
			}
		}
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
