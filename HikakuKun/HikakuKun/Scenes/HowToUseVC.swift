//
//  HowToUseVC.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/09/05.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit
import SnapKit

class HowToUseVC: UIViewController, UIScrollViewDelegate {
	
	let closeBtn		= UIButton()
	let titleL			= UILabel()

	let mainSV			= UIScrollView()
	let smallTitle1L	= UILabel()
	let description1L	= UILabel()
	let smallTitle2L	= UILabel()
	let description3L	= UILabel()
	let description4L	= UILabel()

	let TITLE_H			= 50

	override func viewDidLoad() {
		// background color
		self.view.backgroundColor = UIColor.black

		// close button
		self.closeBtn.setTitle("× close", for: .normal)
		self.closeBtn.setTitleColor(UIColor.init(red: 0/255,
												 green: 163/255,
												 blue: 219/255,
												 alpha: 1.0),
									for: .normal)
		self.closeBtn.backgroundColor = UIColor.clear
		self.closeBtn.layer.borderColor = UIColor.clear.cgColor
		self.view.addSubview(self.closeBtn)
		self.closeBtn.addTarget(self,
								action: #selector(self.closeBtnDidTap(_:)),
								for: .touchUpInside)
		self.closeBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(10)
		}

		// title
		self.titleL.text = "使い方"
		self.titleL.textColor = .white
		self.titleL.font = UIFont.systemFont(ofSize: 30)
		self.view.addSubview(self.titleL)
		self.titleL.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.centerX.equalToSuperview()
		}

		/* ---------------------------------------- */
		/*	main scroll view						*/
		/* ---------------------------------------- */
		var totalHeight: CGFloat = 0

		// 1.initial scene - title
		self.smallTitle1L.text = "初期画面"
		self.smallTitle1L.textColor = .white
		self.smallTitle1L.font = UIFont.boldSystemFont(ofSize: 20)
		self.smallTitle1L.frame = CGRect(x: 0,
										y: 5,
										width: 100,
										height: 25)
		self.mainSV.addSubview(self.smallTitle1L)
		totalHeight += 30

		// 1.initial scene - image
		let img01 = UIImageView(image: UIImage(named: "init_scene"))
		let img01_width = SAFE_AREA_WIDTH * 3/4
		let img01_height = (img01.image?.size.height)! * img01_width/(img01.image?.size.width)!
		img01.frame = CGRect(x: 0,
							 y: totalHeight,
							 width: img01_width,
							 height: img01_height)
		self.mainSV.addSubview(img01)
		totalHeight += img01_height

		// 1.initial scene - description
		self.description1L.text = "←ーーー新しい比較を作成"
		self.description1L.textColor = .red
		self.description1L.font = UIFont.systemFont(ofSize: 20)
		self.description1L.frame = CGRect(x: img01_width - 30,
										  y: 30 + img01_height * 1/5,
										  width: SAFE_AREA_WIDTH - img01_width + 30,
										  height: 20)
		self.description1L.adjustsFontSizeToFitWidth = true
		self.mainSV.addSubview(self.description1L)

		// 2.first main scene - title
		self.smallTitle2L.text = "メイン画面"
		self.smallTitle2L.textColor = .white
		self.smallTitle2L.font = UIFont.boldSystemFont(ofSize: 20)
		self.smallTitle2L.frame = CGRect(x: 0,
										 y: totalHeight + 10,
										 width: 100,
										 height: 25)
		self.mainSV.addSubview(self.smallTitle2L)
		totalHeight += 35

		// 2.first main scene - image
		let img02 = UIImageView(image: UIImage(named: "main_scene_first"))
		let img02_width = SAFE_AREA_WIDTH * 3/4
		let img02_height = (img02.image?.size.height)! * img02_width/(img02.image?.size.width)!
		img02.frame = CGRect(x: 0,
							 y: totalHeight,
							 width: img02_width,
							 height: img02_height)
		self.mainSV.addSubview(img02)
		totalHeight += img02_height

		// 3.second main scene - image
		let img03 = UIImageView(image: UIImage(named: "main_scene_second"))
		let img03_width = SAFE_AREA_WIDTH * 3/4
		let img03_height = (img03.image?.size.height)! * img03_width/(img03.image?.size.width)!
		img03.frame = CGRect(x: 0,
							 y: totalHeight + 5,
							 width: img03_width,
							 height: img03_height)
		self.mainSV.addSubview(img03)

		// 3.second main scene - description
		self.description3L.numberOfLines = 10
		self.description3L.text = "・タイトル\n・比較対象\n・比較項目\n・内容\nを入力する。\n\n"
								+ "比較項目を追加する場合は\n左下の＋ボタンを、\n"
								+ "比較対象を追加する場合は\n右上の＋ボタンを、タップ"
		self.description3L.adjustsFontSizeToFitWidth = true
		self.description3L.textColor = .red
		self.description3L.font = UIFont.systemFont(ofSize: 20)
		self.description3L.frame = CGRect(x: img03_width + 3,
										  y: totalHeight + 30,
										  width: SAFE_AREA_WIDTH - img03_width,
										  height: 200)
		self.mainSV.addSubview(self.description3L)
		totalHeight += img03_height + 5

		// 4.main scene full - image
		let img04 = UIImageView(image: UIImage(named: "main_scene_full"))
		let img04_width = SAFE_AREA_WIDTH * 3/4
		let img04_height = (img04.image?.size.height)! * img04_width/(img04.image?.size.width)!
		img04.frame = CGRect(x: 0,
							 y: totalHeight + 5,
							 width: img04_width,
							 height: img04_height)
		self.mainSV.addSubview(img04)

		// 4.main scene full - description
		self.description4L.numberOfLines = 6
		self.description4L.text = "項目は、\nメモを除いて最大7個\n"
								+ "比較対象は、\n最大5個\n(機種によっては4個)\nまで追加可能"
		self.description4L.adjustsFontSizeToFitWidth = true
		self.description4L.textColor = .red
		self.description4L.font = UIFont.systemFont(ofSize: 20)
		self.description4L.frame = CGRect(x: img04_width + 3,
										  y: totalHeight + 30,
										  width: SAFE_AREA_WIDTH - img04_width,
										  height: 120)
		self.mainSV.addSubview(self.description4L)
		totalHeight += img03_height + 5

		self.mainSV.backgroundColor = UIColor.black
		self.view.addSubview(self.mainSV)
		self.mainSV.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
			make.bottom.equalToSuperview()
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(0)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(0)
		}
		self.mainSV.contentSize = CGSize(width: SAFE_AREA_WIDTH,
										 height: totalHeight)
		self.mainSV.delegate = self
		/* ---------------------------------------- */
		/*	main scroll view	end					*/
		/* ---------------------------------------- */
	}
	
	/// close button action
	/// - Parameter sender: UIButton
	@objc func closeBtnDidTap(_ sender: UIButton) {
		self.dismiss(animated: true)
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
