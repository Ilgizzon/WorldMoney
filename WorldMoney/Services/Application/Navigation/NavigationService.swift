//
//  NavigationService.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import Foundation
import UIKit

public class NavigationService {

    private var screenService: ScreenService
    
    init(screenService: ScreenService) {
        self.screenService = screenService
    }
    
    public var presentingController: UINavigationController {
        guard
            var presentingVC = screenService.window.rootViewController?.presentingViewController as? UINavigationController
        else {
            return screenService.window.rootViewController as! UINavigationController
        }

        if let presentingViewController = presentingVC.presentingViewController as? UINavigationController {
            presentingVC = presentingViewController
        }
        return presentingVC
    }

    public var presentedController: UIViewController {
        guard
            var presentedVC = screenService.window.rootViewController?.presentedViewController
        else {
            return screenService.window.rootViewController!
        }
        
        if let presentedViewController = presentedVC.presentedViewController {
            presentedVC = presentedViewController
        }
        
        return presentedVC
    }

    public func setRoot(_ rootController: UIViewController, animation: Bool = false) {
        var snapshot: UIView?
        if animation {
            snapshot = screenService.window.snapshotView(afterScreenUpdates: true)
        }
        
        if let rootViewController = screenService.window.rootViewController {

            if rootViewController.isKind(of: UINavigationController.self) {
                let navigationController = screenService.window.rootViewController as? UINavigationController
                navigationController?.viewControllers.removeAll()
            }
            
            screenService.window.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
        
        let navController = UINavigationController(rootViewController: rootController)
        screenService.window.rootViewController = navController
        screenService.window.makeKeyAndVisible()
        
        if let snapshot = snapshot {
            
            snapshot.alpha = 1.0
            screenService.window.addSubview(snapshot)
            
            UIView.animate(
                withDuration: 0.2,
                animations: { snapshot.alpha = 0.0 },
                completion: { _ in snapshot.removeFromSuperview() }
            )
        }
    }
        
    public func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        presentedController.present(
            navigationController,
            animated: animated,
            completion: completion
        )
    }
    
    public func dismiss(animation animaton: Bool = true, completion: (() -> Void)? = nil) {
        let navigationController = presentedController as! UINavigationController
        navigationController.dismiss(animated: animaton, completion: completion)
    }
    
    public func dismissWithVC(
        navigationController: UINavigationController,
        animation animaton: Bool = true,
        completion: @escaping () -> Void
    ) {
        navigationController.dismiss(animated: animaton, completion: nil)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                completion()
            })
        }
        
        navigationController.dismiss(animated: animaton, completion: nil)
        CATransaction.commit()
    }
    
    public func dismissToRoot(animation animaton: Bool = true, completion: (() -> Void)? = nil) {
        let navigationController: UINavigationController = presentingController

        guard presentingController != presentedController else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                completion?()
            })
            return
        }
        navigationController.dismiss(animated: animaton, completion: completion)
    }
}
