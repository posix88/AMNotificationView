//
//  AMNotificationViewController.swift
//
//  Created by Musolino, Antonino Francesco on 17/01/17.
//  Copyright © 2017 Musolino, Antonino Francesco. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

public class AMNotificationManager: NSObject
{
	open static let sharedInstance = AMNotificationManager()
	
	public var notificationAnimationDuration: TimeInterval = 0.4
	public var notificationDisplayTime: TimeInterval = 3
	public var notificationSystemSound: SystemSoundID?
	public var notificationCustomSound: AVAudioFile?
	public var activeNotification: AMNotificationView?
	public var notificationYOffset: CGFloat = 0
	
	public var isNotificationActive: Bool
	{
		return (self.activeNotification != nil)
	}
	
	public var notificationImage: UIImage?
	public var notificationWidth: CGFloat = UIScreen.main.bounds.width
	private var notificationHeight: CGFloat = 87
	
	public func showNotification(withText text: String, completion:(()->Void)?)
	{
		if self.isNotificationActive
		{
			let _ = dismissNotification(notification:self.activeNotification!)
			{ _ in
				self.showNotification(withText: text,completion: completion)
			}
		}
		else
		{
			let notification = AMNotificationView(notificationText: text, image: notificationImage, viewWidth: notificationWidth, viewHeight: notificationHeight, action: completion)
			displayNotification(notification: notification, withCompletion: completion)
		}
	}
	
	private func displayNotification(notification: AMNotificationView, withCompletion completion:(()->Void)? = nil)
	{
		self.activeNotification = notification
		
		let mainWindow = UIApplication.shared.keyWindow
		mainWindow?.addSubview(notification)

		var newCenter: CGPoint
		let newY = (notification.frame.height / 2.0) + notificationYOffset
		newCenter = CGPoint(x: notification.center.x, y: newY)
		
		if let notificationSound = notificationSystemSound
		{
			AudioServicesPlayAlertSound(notificationSound)
		}
		else if let notificationSound = notificationCustomSound
		{
			let audioPlayer = AVPlayer(playerItem: AVPlayerItem(url: notificationSound.url))
			audioPlayer.play()
		}

		UIView.animate(withDuration: notificationAnimationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
			notification.center = newCenter
		})

		let delayTime = DispatchTime.now() + Double(Int64(notificationDisplayTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
			DispatchQueue.main.asyncAfter(deadline: delayTime, execute: { _ in
					self.dismissNotification(notification: notification, withCompletion: completion)
		})
	}

	public func dismissNotification(notification: AMNotificationView, withCompletion completion:(()->Void)? = nil) -> Void
	{
		guard activeNotification != nil else {
			return
		}

		var newCenter: CGPoint
		newCenter = CGPoint(x: notification.center.x, y: -(notification.frame.height / 2.0))
		
		UIView.animate(withDuration: notificationAnimationDuration, animations:
		{
			notification.center = newCenter
		},
		completion: {_ in
			notification.removeFromSuperview()
			self.activeNotification = nil
			completion?()
		})
	}

}

