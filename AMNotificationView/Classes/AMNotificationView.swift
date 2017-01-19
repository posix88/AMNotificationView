//
//  AMNotificationView.swift
//  Created by Musolino, Antonino Francesco on 16/01/17.
//  Copyright © 2017 Musolino, Antonino Francesco All rights reserved.
//

import Foundation
import UIKit

public class AMNotificationView:UIView, UIGestureRecognizerDelegate
{
	@IBOutlet weak open var notificationImageView: UIImageView!
	@IBOutlet weak open var notificationTextView: UITextView!
	@IBOutlet weak open var notificationActionButton: UIButton!
	
	private var view: UIView!
	private var touchAction: (() -> Void)?
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
	}
	
	public init(notificationText:String, image: UIImage?, viewWidth: CGFloat, viewHeight: CGFloat, action: (() -> Void)?)
	{
		let newFrame = CGRect(x: 0, y: -viewHeight, width: viewWidth, height: viewHeight)
		super.init(frame: newFrame)
		xibSetup()
		notificationTextView.text = notificationText
		if image != nil
		{
			notificationImageView.image = image
		}
		else
		{
			notificationImageView.removeFromSuperview()
		}
		touchAction	= action
		
		let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closingAction))
		self.addGestureRecognizer(tapGestureRecognizer)
	}
	
	public required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
	}

	@IBAction fileprivate func closingAction()
	{
		AMNotificationManager.sharedInstance.dismissNotification(notification: self, withCompletion: touchAction)
	}
	
	fileprivate func xibSetup()
	{
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
		addSubview(view)
	}
	
	
	fileprivate func loadViewFromNib() -> UIView
	{
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "NotificationView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
}
