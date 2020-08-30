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

class CompareMainVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

	let backBtn			= UIButton()
	let groupNameTF		= UITextField()
	let saveBtn			= UIButton()
	let nameTF_1		= UITextField()
	let nameTF_2		= UITextField()
	let nameTF_3		= UITextField()
	let nameTF_4		= UITextField()
	let nameTF_5		= UITextField()
	let addNewNameBtn	= UIButton()
	let addNewItemBtn	= UIButton()

	let itemsSV			= UIScrollView()
	let itemTF_01		= UITextField()
	let itemTF_02		= UITextField()
	let itemTF_03		= UITextField()
	let itemTF_04		= UITextField()
	let itemTF_05		= UITextField()
	let itemTF_06		= UITextField()
	let itemTF_07		= UITextField()
	let contentTF_1_01	= UITextField()
	let contentTF_1_02	= UITextField()
	let contentTF_1_03	= UITextField()
	let contentTF_1_04	= UITextField()
	let contentTF_1_05	= UITextField()
	let contentTF_1_06	= UITextField()
	let contentTF_1_07	= UITextField()
	let contentTF_2_01	= UITextField()
	let contentTF_2_02	= UITextField()
	let contentTF_2_03	= UITextField()
	let contentTF_2_04	= UITextField()
	let contentTF_2_05	= UITextField()
	let contentTF_2_06	= UITextField()
	let contentTF_2_07	= UITextField()
	let contentTF_3_01	= UITextField()
	let contentTF_3_02	= UITextField()
	let contentTF_3_03	= UITextField()
	let contentTF_3_04	= UITextField()
	let contentTF_3_05	= UITextField()
	let contentTF_3_06	= UITextField()
	let contentTF_3_07	= UITextField()
	let contentTF_4_01	= UITextField()
	let contentTF_4_02	= UITextField()
	let contentTF_4_03	= UITextField()
	let contentTF_4_04	= UITextField()
	let contentTF_4_05	= UITextField()
	let contentTF_4_06	= UITextField()
	let contentTF_4_07	= UITextField()
	let contentTF_5_01	= UITextField()
	let contentTF_5_02	= UITextField()
	let contentTF_5_03	= UITextField()
	let contentTF_5_04	= UITextField()
	let contentTF_5_05	= UITextField()
	let contentTF_5_06	= UITextField()
	let contentTF_5_07	= UITextField()
	let memoLabel		= UILabel()
	let memoTV_1		= UITextView()
	let memoTV_2		= UITextView()
	let memoTV_3		= UITextView()
	let memoTV_4		= UITextView()
	let memoTV_5		= UITextView()

	var groupId		= -1
	var compareNum	= 1
	var colNum		= 2
	var rowNum		= 1

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
			items = try CompareItemRealm().getItems(groupId: groupId)
			contents = try CompareContentsRealm().getContentsList(groupId: groupId)
			//update contents num
			if( contents.count > 1 ) {
				compareNum = contents.count
			}
		} catch {
			print("error")
		}

		// calc width
		let itemWidth = floor_2(num: (SAFE_AREA_WIDTH - RIGHT_W) / 6)
		var eachWidth = floor_2(num: (SAFE_AREA_WIDTH - itemWidth) / 5)
		if( colNum <= 2 ) {
			eachWidth = floor_2(num: (SAFE_AREA_WIDTH - RIGHT_W - itemWidth) / 2)
		} else if( SAFE_AREA_WIDTH >= 800 ) {
			if( colNum < 5 ) {
				eachWidth = floor_2(num: (SAFE_AREA_WIDTH - RIGHT_W - itemWidth) / CGFloat(colNum))
			}
		} else {
			if( colNum < 4 ) {
				eachWidth = floor_2(num: (SAFE_AREA_WIDTH - RIGHT_W - itemWidth) / CGFloat(colNum))
			}
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
			if( (contents.filter("id = 1").first?.name.count)! > 0 ) {
				self.nameTF_2.text = contents.filter("id = 1").first?.name
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
		if( colNum >= 3 ) {
			for nameNum in 3...colNum {
				var nameTF = UITextField()
				switch nameNum {
					case 3:
						nameTF = self.nameTF_3
						self.view.addSubview(nameTF)
						if( contents.filter("id = 2").first != nil ) {
							nameTF.text = contents.filter("id = 2").first?.name
						} else {
							nameTF.placeholder = "比較対象名を入力"
						}
					case 4:
						nameTF = self.nameTF_4
						self.view.addSubview(nameTF)
						if( contents.filter("id = 3").first != nil ) {
							nameTF.text = contents.filter("id = 3").first?.name
						} else {
							nameTF.placeholder = "比較対象名を入力"
						}
					case 5:
						nameTF = self.nameTF_5
						self.view.addSubview(nameTF)
						if( contents.filter("id = 4").first != nil ) {
							nameTF.text = contents.filter("id = 4").first?.name
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

		// add new name button
		if( ( SAFE_AREA_WIDTH >= 800 && colNum <= 4 )
			|| ( SAFE_AREA_WIDTH < 800 && colNum <= 3 ) ) {
			self.addNewNameBtn.setTitle("＋", for: .normal)
			self.addNewNameBtn.setTitleColor(UIColor.blue, for: .normal)
			self.addNewNameBtn.backgroundColor = UIColor.clear
			self.addNewNameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
			self.addNewNameBtn.titleLabel?.adjustsFontSizeToFitWidth = true
			self.addNewNameBtn.titleLabel?.baselineAdjustment = .alignCenters
			self.addNewNameBtn.layer.borderColor = UIColor.blue.cgColor
			self.addNewNameBtn.layer.borderWidth = 1.0
			self.addNewNameBtn.layer.cornerRadius = 12.0
			self.view.addSubview(self.addNewNameBtn)
			self.addNewNameBtn.addTarget(self,
										 action: #selector(self.addNewNameBtnDidTap(_:)),
										 for: .touchUpInside)
			self.addNewNameBtn.snp.makeConstraints { (make) in
				make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + 3)
				make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + 27)
				make.left.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(27)
				make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(3)
			}
		}

		/* ---------------------------------------- */
		/*	items(scroll view)						*/
		/* ---------------------------------------- */
		// item 1
		if( items.first != nil ) {
			if( (items.first?.item1.count)! > 0 ) {
				self.itemTF_01.text = items.first?.item1
				self.contentTF_1_01.text = contents.first?.content1
				self.contentTF_2_01.text = contents.filter("id = 1").first?.content1
			} else {
				self.itemTF_01.placeholder = "比較項目1"
			}
		} else {
			self.itemTF_01.placeholder = "比較項目1"
		}
		self.itemTF_01.layer.borderColor = UIColor.black.cgColor
		self.itemTF_01.layer.borderWidth = 0.5
		self.itemTF_01.adjustsFontSizeToFitWidth = true
		self.itemTF_01.frame = CGRect(x: 0,
									  y: 0,
									  width: Int(itemWidth),
									  height: ITEM_H)
		self.itemsSV.addSubview(self.itemTF_01)
		self.itemTF_01.delegate = self

		self.contentTF_1_01.layer.borderColor = UIColor.black.cgColor
		self.contentTF_1_01.layer.borderWidth = 0.5
		self.contentTF_1_01.adjustsFontSizeToFitWidth = true
		self.contentTF_1_01.frame = CGRect(x: Int(itemWidth),
										   y: 0,
										   width: Int(eachWidth),
										   height: ITEM_H)
		self.itemsSV.addSubview(self.contentTF_1_01)
		self.contentTF_1_01.delegate = self

		self.contentTF_2_01.layer.borderColor = UIColor.black.cgColor
		self.contentTF_2_01.layer.borderWidth = 0.5
		self.contentTF_2_01.adjustsFontSizeToFitWidth = true
		self.contentTF_2_01.frame = CGRect(x: Int(itemWidth + eachWidth),
										   y: 0,
										   width: Int(eachWidth),
										   height: ITEM_H)
		self.itemsSV.addSubview(self.contentTF_2_01)
		self.contentTF_2_01.delegate = self

		if( colNum >= 3 ) {
			self.contentTF_3_01.text = contents.filter("id = 2").first?.content1
			self.contentTF_3_01.layer.borderColor = UIColor.black.cgColor
			self.contentTF_3_01.layer.borderWidth = 0.5
			self.contentTF_3_01.adjustsFontSizeToFitWidth = true
			self.contentTF_3_01.frame = CGRect(x: Int(itemWidth + 2*eachWidth),
											   y: 0,
											   width: Int(eachWidth),
											   height: ITEM_H)
			self.itemsSV.addSubview(self.contentTF_3_01)
			self.contentTF_3_01.delegate = self
		}
		if( colNum >= 4 ) {
			self.contentTF_4_01.text = contents.filter("id = 3").first?.content1
			self.contentTF_4_01.layer.borderColor = UIColor.black.cgColor
			self.contentTF_4_01.layer.borderWidth = 0.5
			self.contentTF_4_01.adjustsFontSizeToFitWidth = true
			self.contentTF_4_01.frame = CGRect(x: Int(itemWidth + 3*eachWidth),
											   y: 0,
											   width: Int(eachWidth),
											   height: ITEM_H)
			self.itemsSV.addSubview(self.contentTF_4_01)
			self.contentTF_4_01.delegate = self
		}
		if( colNum == 5 ) {
			self.contentTF_5_01.text = contents.filter("id = 4").first?.content1
			self.contentTF_5_01.layer.borderColor = UIColor.black.cgColor
			self.contentTF_5_01.layer.borderWidth = 0.5
			self.contentTF_5_01.adjustsFontSizeToFitWidth = true
			self.contentTF_5_01.frame = CGRect(x: Int(itemWidth + 4*eachWidth),
											   y: 0,
											   width: Int(eachWidth),
											   height: ITEM_H)
			self.itemsSV.addSubview(self.contentTF_5_01)
			self.contentTF_5_01.delegate = self
		}

		// item 2~
		if( rowNum >= 2 ) {
			for itemNum in 1..<rowNum {
				var itemNameTF = UITextField()
				var contentTF_1 = UITextField()
				var contentTF_2 = UITextField()
				var contentTF_3 = UITextField()
				var contentTF_4 = UITextField()
				var contentTF_5 = UITextField()
				switch itemNum {
					case 1:
						itemNameTF = itemTF_02
						contentTF_1 = contentTF_1_02
						contentTF_2 = contentTF_2_02
						contentTF_3 = contentTF_3_02
						contentTF_4 = contentTF_4_02
						contentTF_5 = contentTF_5_02
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item2
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content2
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content2
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content2
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content2
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content2
						}
					case 2:
						itemNameTF = itemTF_03
						contentTF_1 = contentTF_1_03
						contentTF_2 = contentTF_2_03
						contentTF_3 = contentTF_3_03
						contentTF_4 = contentTF_4_03
						contentTF_5 = contentTF_5_03
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item3
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content3
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content3
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content3
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content3
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content3
						}
					case 3:
						itemNameTF = itemTF_04
						contentTF_1 = contentTF_1_04
						contentTF_2 = contentTF_2_04
						contentTF_3 = contentTF_3_04
						contentTF_4 = contentTF_4_04
						contentTF_5 = contentTF_5_04
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item4
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content4
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content4
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content4
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content4
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content4
						}
					case 4:
						itemNameTF = itemTF_05
						contentTF_1 = contentTF_1_05
						contentTF_2 = contentTF_2_05
						contentTF_3 = contentTF_3_05
						contentTF_4 = contentTF_4_05
						contentTF_5 = contentTF_5_05
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item5
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content5
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content5
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content5
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content5
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content5
						}
					case 5:
						itemNameTF = itemTF_06
						contentTF_1 = contentTF_1_06
						contentTF_2 = contentTF_2_06
						contentTF_3 = contentTF_3_06
						contentTF_4 = contentTF_4_06
						contentTF_5 = contentTF_5_06
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item6
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content6
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content6
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content6
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content6
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content6
						}
					case 6:
						itemNameTF = itemTF_07
						contentTF_1 = contentTF_1_07
						contentTF_2 = contentTF_2_07
						contentTF_3 = contentTF_3_07
						contentTF_4 = contentTF_4_07
						contentTF_5 = contentTF_5_07
						self.itemsSV.addSubview(itemNameTF)
						self.itemsSV.addSubview(contentTF_1)
						self.itemsSV.addSubview(contentTF_2)
						if( colNum >= 3 ) {
							self.itemsSV.addSubview(contentTF_3)
						}
						if( colNum >= 4 ) {
							self.itemsSV.addSubview(contentTF_4)
						}
						if( colNum >= 5 ) {
							self.itemsSV.addSubview(contentTF_5)
						}
						if( items.first != nil ) {
							itemNameTF.text = items.first?.item7
						}
						if( contents.filter("id = 0").first != nil ) {
							contentTF_1.text = contents.filter("id = 0").first?.content7
						}
						if( contents.filter("id = 1").first != nil ) {
							contentTF_2.text = contents.filter("id = 1").first?.content7
						}
						if( contents.filter("id = 2").first != nil ) {
							contentTF_3.text = contents.filter("id = 2").first?.content7
						}
						if( contents.filter("id = 3").first != nil ) {
							contentTF_4.text = contents.filter("id = 3").first?.content7
						}
						if( contents.filter("id = 4").first != nil ) {
							contentTF_5.text = contents.filter("id = 4").first?.content7
						}
					default:
						break
				}
				itemNameTF.layer.borderColor = UIColor.black.cgColor
				itemNameTF.layer.borderWidth = 0.5
				itemNameTF.adjustsFontSizeToFitWidth = true
				itemNameTF.frame = CGRect(x: 0,
										  y: itemNum * ITEM_H,
										  width: Int(itemWidth),
										  height: ITEM_H)
				itemNameTF.delegate = self

				contentTF_1.layer.borderColor = UIColor.black.cgColor
				contentTF_1.layer.borderWidth = 0.5
				contentTF_1.adjustsFontSizeToFitWidth = true
				contentTF_1.frame = CGRect(x: Int(itemWidth),
										   y: itemNum * ITEM_H,
										   width: Int(eachWidth),
										   height: ITEM_H)
				contentTF_1.delegate = self

				contentTF_2.layer.borderColor = UIColor.black.cgColor
				contentTF_2.layer.borderWidth = 0.5
				contentTF_2.adjustsFontSizeToFitWidth = true
				contentTF_2.frame = CGRect(x: Int(itemWidth + eachWidth),
										   y: itemNum * ITEM_H,
										   width: Int(eachWidth),
										   height: ITEM_H)
				contentTF_2.delegate = self

				if( colNum >= 3 ) {
					contentTF_3.layer.borderColor = UIColor.black.cgColor
					contentTF_3.layer.borderWidth = 0.5
					contentTF_3.adjustsFontSizeToFitWidth = true
					contentTF_3.frame = CGRect(x: Int(itemWidth + 2*eachWidth),
											   y: itemNum * ITEM_H,
											   width: Int(eachWidth),
											   height: ITEM_H)
					contentTF_3.delegate = self
				}
				if( colNum >= 4 ) {
					contentTF_4.layer.borderColor = UIColor.black.cgColor
					contentTF_4.layer.borderWidth = 0.5
					contentTF_4.adjustsFontSizeToFitWidth = true
					contentTF_4.frame = CGRect(x: Int(itemWidth + 3*eachWidth),
											   y: itemNum * ITEM_H,
											   width: Int(eachWidth),
											   height: ITEM_H)
					contentTF_4.delegate = self
				}
				if( colNum >= 5 ) {
					contentTF_5.layer.borderColor = UIColor.black.cgColor
					contentTF_5.layer.borderWidth = 0.5
					contentTF_5.adjustsFontSizeToFitWidth = true
					contentTF_5.frame = CGRect(x: Int(itemWidth + 4*eachWidth),
											   y: itemNum * ITEM_H,
											   width: Int(eachWidth),
											   height: ITEM_H)
					contentTF_5.delegate = self
				}
			}
		}

		// add new item button
		if( rowNum <= 6 ) {
			self.addNewItemBtn.setTitle("＋", for: .normal)
			self.addNewItemBtn.setTitleColor(UIColor.blue, for: .normal)
			self.addNewItemBtn.backgroundColor = UIColor.clear
			self.addNewItemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
			self.addNewItemBtn.titleLabel?.adjustsFontSizeToFitWidth = true
			self.addNewItemBtn.titleLabel?.baselineAdjustment = .alignCenters
			self.addNewItemBtn.layer.borderColor = UIColor.blue.cgColor
			self.addNewItemBtn.layer.borderWidth = 1.0
			self.addNewItemBtn.layer.cornerRadius = 12.0
			self.addNewItemBtn.frame = CGRect(x: 3,
											  y: (rowNum+3) * ITEM_H + 3,
											  width: 24,
											  height: 24)
			self.itemsSV.addSubview(self.addNewItemBtn)
			self.addNewItemBtn.addTarget(self,
										 action: #selector(self.addNewItemBtnDidTap(_:)),
										 for: .touchUpInside)
		} else {
			self.addNewItemBtn.removeFromSuperview()
		}

		// memo label
		self.memoLabel.text = "メモ"
		self.memoLabel.textColor = .black
		self.memoLabel.layer.borderColor = UIColor.black.cgColor
		self.memoLabel.layer.borderWidth = 0.5
		self.memoLabel.frame = CGRect(x: 0,
									  y: rowNum * ITEM_H,
									  width: Int(itemWidth),
									  height: ITEM_H * 3)
		self.itemsSV.addSubview(self.memoLabel)

		// memo 1~colNum
		for col in 1...colNum {
			var memoTV = UITextView()
			switch col {
				case 1:
					memoTV = memoTV_1
					memoTV.text = contents.filter("id = 0").first?.memo
				case 2:
					memoTV = memoTV_2
					memoTV.text = contents.filter("id = 1").first?.memo
				case 3:
					memoTV = memoTV_3
					memoTV.text = contents.filter("id = 2").first?.memo
				case 4:
					memoTV = memoTV_4
					memoTV.text = contents.filter("id = 3").first?.memo
				case 5:
					memoTV = memoTV_5
					memoTV.text = contents.filter("id = 4").first?.memo
				default:
					break
			}
			memoTV.textColor = .black
			memoTV.layer.borderColor = UIColor.black.cgColor
			memoTV.layer.borderWidth = 0.5
			memoTV.frame = CGRect(x: Int(itemWidth + CGFloat(colNum-1)*eachWidth),
								  y: rowNum * ITEM_H,
								  width: Int(eachWidth),
								  height: ITEM_H*3)
			self.itemsSV.addSubview(memoTV)
		}

		// add items(scroll view)
		self.view.addSubview(self.itemsSV)
		self.itemsSV.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H + NAME_H)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(BOTTOM_H)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(0)
			if( SAFE_AREA_WIDTH >= 800 && colNum <= 4 )
				|| ( SAFE_AREA_WIDTH < 800 && colNum <= 3 ) {
				make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(RIGHT_W)
			} else {
				make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(0)
			}
		}
		self.itemsSV.contentSize = CGSize(width: itemWidth + eachWidth * CGFloat(colNum),
										  height: CGFloat(ITEM_H * (rowNum+4)))
		self.itemsSV.delegate = self
		/* ---------------------------------------- */
		/*	items(scroll view)	end					*/
		/* ---------------------------------------- */
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
		let colItem = CompareItemRealm()
		colItem.groupId = groupId
		colItem.groupName = groupNameTF.text!
		colItem.item1 = itemTF_01.text!
		colItem.item2 = itemTF_02.text!
		colItem.item3 = itemTF_03.text!
		colItem.item4 = itemTF_04.text!
		colItem.item5 = itemTF_05.text!
		colItem.item6 = itemTF_06.text!
		colItem.item7 = itemTF_07.text!
		let dt = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMddHHmmss",
															options: 0,
															locale: Locale(identifier: "ja_JP"))
		colItem.timestamp = dateFormatter.string(from: dt)

		//insert data
		let realm = try! Realm(configuration: config)
		try! realm.write {
			realm.add(colItem)
		}

		for col in 0..<colNum {
			let colContents = CompareContentsRealm()
			colContents.groupId = groupId
			colContents.id = col
			if( col == 0 ) {
				colContents.name = nameTF_1.text!
				colContents.content1 = contentTF_1_01.text!
				colContents.content2 = contentTF_1_02.text!
				colContents.content3 = contentTF_1_03.text!
				colContents.content4 = contentTF_1_04.text!
				colContents.content5 = contentTF_1_05.text!
				colContents.content6 = contentTF_1_06.text!
				colContents.content7 = contentTF_1_07.text!
				colContents.memo = memoTV_1.text!
			} else if( col == 1 ) {
				colContents.name = nameTF_2.text!
				colContents.content1 = contentTF_2_01.text!
				colContents.content2 = contentTF_2_02.text!
				colContents.content3 = contentTF_2_03.text!
				colContents.content4 = contentTF_2_04.text!
				colContents.content5 = contentTF_2_05.text!
				colContents.content6 = contentTF_2_06.text!
				colContents.content7 = contentTF_2_07.text!
				colContents.memo = memoTV_2.text!
			} else if( col == 2 ) {
				colContents.name = nameTF_3.text!
				colContents.content1 = contentTF_3_01.text!
				colContents.content2 = contentTF_3_02.text!
				colContents.content3 = contentTF_3_03.text!
				colContents.content4 = contentTF_3_04.text!
				colContents.content5 = contentTF_3_05.text!
				colContents.content6 = contentTF_3_06.text!
				colContents.content7 = contentTF_3_07.text!
				colContents.memo = memoTV_3.text!
			} else if( col == 3 ) {
				colContents.name = nameTF_4.text!
				colContents.content1 = contentTF_4_01.text!
				colContents.content2 = contentTF_4_02.text!
				colContents.content3 = contentTF_4_03.text!
				colContents.content4 = contentTF_4_04.text!
				colContents.content5 = contentTF_4_05.text!
				colContents.content6 = contentTF_4_06.text!
				colContents.content7 = contentTF_4_07.text!
				colContents.memo = memoTV_4.text!
			} else if( col == 4 ) {
				colContents.name = nameTF_5.text!
				colContents.content1 = contentTF_5_01.text!
				colContents.content2 = contentTF_5_02.text!
				colContents.content3 = contentTF_5_03.text!
				colContents.content4 = contentTF_5_04.text!
				colContents.content5 = contentTF_5_05.text!
				colContents.content6 = contentTF_5_06.text!
				colContents.content7 = contentTF_5_07.text!
				colContents.memo = memoTV_5.text!
			}
			colContents.timestamp = dateFormatter.string(from: dt)

			//insert data
			try! realm.write {
				realm.add(colContents)
			}
		}

		//complete message
		let defaultAction = UIAlertAction(title: "OK",
										  style: .default,
										  handler:{(action: UIAlertAction!) -> Void in})
		let alert = UIAlertController(title: "",
									  message: "保存されました。",
									  preferredStyle: .alert)
		alert.addAction(defaultAction)
		present(alert, animated: true, completion: nil)

		//redisplay
		self.viewDidLoad()
	}

	/// addNewName button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func addNewNameBtnDidTap(_ sender: UIButton) {
		colNum = colNum + 1
		//redisplay
		self.loadView()
		self.viewDidLoad()
	}

	/// addNewItem button action
	/// - Parameter sender: UIButton
	/// - Authors: Nozomi Koyama
	@objc func addNewItemBtnDidTap(_ sender: UIButton) {
		rowNum = rowNum + 1
		//redisplay
		self.loadView()
		self.viewDidLoad()
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
		self.itemTF_01.resignFirstResponder()
		self.itemTF_02.resignFirstResponder()
		self.itemTF_03.resignFirstResponder()
		self.itemTF_04.resignFirstResponder()
		self.itemTF_05.resignFirstResponder()
		self.itemTF_06.resignFirstResponder()
		self.itemTF_07.resignFirstResponder()
		self.contentTF_1_01.resignFirstResponder()
		self.contentTF_1_02.resignFirstResponder()
		self.contentTF_1_03.resignFirstResponder()
		self.contentTF_1_04.resignFirstResponder()
		self.contentTF_1_05.resignFirstResponder()
		self.contentTF_1_06.resignFirstResponder()
		self.contentTF_1_07.resignFirstResponder()
		self.contentTF_2_01.resignFirstResponder()
		self.contentTF_2_02.resignFirstResponder()
		self.contentTF_2_03.resignFirstResponder()
		self.contentTF_2_04.resignFirstResponder()
		self.contentTF_2_05.resignFirstResponder()
		self.contentTF_2_06.resignFirstResponder()
		self.contentTF_2_07.resignFirstResponder()
		self.contentTF_3_01.resignFirstResponder()
		self.contentTF_3_02.resignFirstResponder()
		self.contentTF_3_03.resignFirstResponder()
		self.contentTF_3_04.resignFirstResponder()
		self.contentTF_3_05.resignFirstResponder()
		self.contentTF_3_06.resignFirstResponder()
		self.contentTF_3_07.resignFirstResponder()
		self.contentTF_4_01.resignFirstResponder()
		self.contentTF_4_02.resignFirstResponder()
		self.contentTF_4_03.resignFirstResponder()
		self.contentTF_4_04.resignFirstResponder()
		self.contentTF_4_05.resignFirstResponder()
		self.contentTF_4_06.resignFirstResponder()
		self.contentTF_4_07.resignFirstResponder()
		self.contentTF_5_01.resignFirstResponder()
		self.contentTF_5_02.resignFirstResponder()
		self.contentTF_5_03.resignFirstResponder()
		self.contentTF_5_04.resignFirstResponder()
		self.contentTF_5_05.resignFirstResponder()
		self.contentTF_5_06.resignFirstResponder()
		self.contentTF_5_07.resignFirstResponder()
		self.memoTV_1.resignFirstResponder()
		self.memoTV_2.resignFirstResponder()
		self.memoTV_3.resignFirstResponder()
		self.memoTV_4.resignFirstResponder()
		self.memoTV_5.resignFirstResponder()
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
}
