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
		self.mainSV.addSubview(self.description1L)

		// 2.first main scene - title
		self.smallTitle2L.text = "メイン画面"
		self.smallTitle2L.textColor = .white
		self.smallTitle2L.font = UIFont.boldSystemFont(ofSize: 20)
		self.smallTitle2L.frame = CGRect(x: 0,
										 y: totalHeight + 5,
										 width: 100,
										 height: 25)
		self.mainSV.addSubview(self.smallTitle2L)

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
