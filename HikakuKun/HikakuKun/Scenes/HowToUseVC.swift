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
	let smallTitleL		= UILabel()
	
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
		// 1.first scene
		self.smallTitleL.text = "初期画面"
		self.smallTitleL.textColor = .white
		self.smallTitleL.font = UIFont.systemFont(ofSize: 20)
		self.smallTitleL.frame = CGRect(x: 0,
										y: 5,
										width: 100,
										height: 25)
		self.mainSV.addSubview(self.smallTitleL)
		
		let img01 = UIImageView(image: UIImage(named: "init_scene"))
		let img01_width = (img01.image?.size.width)! * 0.7
		let img01_height = (img01.image?.size.height)! * 0.7
		img01.frame = CGRect(x: 0,
							 y: 30,
							 width: img01_width,
							 height: img01_height)
		self.mainSV.addSubview(img01)

		self.mainSV.backgroundColor = UIColor.black
		self.view.addSubview(self.mainSV)
		self.mainSV.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(TITLE_H)
			make.bottom.equalToSuperview()
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(0)
			make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).inset(0)
		}
		self.mainSV.contentSize = CGSize(width: SAFE_AREA_WIDTH,
										 height: 1000)
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
