//
//  DefaultScreenLocker.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit
import SnapKit

extension Dependency {
    static func registerDefaultScreenLocker() {
        register(ILocker.self, name: .defaultLocker) {
            DefaultScreenLocker()
        }.scope(.application)
    }
}

final class DefaultScreenLocker: BaseViewController, ILocker {
    
    private let loadingView = LoadingView()
    
    private var containerWindow: UIWindow?
    
    private let locker = NSRecursiveLock()
    
    private var counter = 0 {
        didSet {
            print("Counter is:", counter)
            handleCounter()
        }
    }
    
    override func setup() {
        super.setup()
        loadingView.animate()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(loadingView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(heightComputed(88))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) { }
    
    func lock() {
        print("🔒 lock")
        locker.lock()
        counter +=  1
        locker.unlock()
    }
    
    func unlock() {
        print("🔓 unlock")
        locker.lock()
        counter = counter == 0 ? 0 : counter - 1
        locker.unlock()
    }
    
    func forceUnlock() {
        print("🔓 unlock")
        locker.lock()
        counter = 0
        locker.unlock()
    }
    
    private func handleCounter() {
        let windowScene = UIApplication.shared
                        .connectedScenes
                        .filter { $0.activationState == .foregroundActive }
                        .first
        if counter > 0 {
            DispatchQueue.main.async { [unowned self] in
                if let windowScene = windowScene as? UIWindowScene {
                    loadingView.animate()
                    containerWindow = UIWindow(windowScene: windowScene)
                    containerWindow?.windowLevel = UIWindow.Level.normal + 2
                    containerWindow?.backgroundColor = .clear
                    containerWindow?.rootViewController = self
                    containerWindow?.makeKeyAndVisible()
                    UIView.animate(withDuration: 0.25) {
                        self.view.backgroundColor = .black.withAlphaComponent(0.2)
                        self.loadingView.backgroundColor = .white.withAlphaComponent(1)
                    }
                }
            }
        } else {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                view.backgroundColor = .black.withAlphaComponent(0)
                loadingView.backgroundColor = .white.withAlphaComponent(0)
            } completion: { [unowned self] _ in
                containerWindow?.rootViewController = nil
                containerWindow = nil
            }
        }
    }
}

private class LoadingView: BaseView {
    
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeStart = 0
        layer.strokeEnd = 0.15
        layer.fillColor = nil
        layer.lineCap = .round
        layer.lineJoin = .round
        return layer
    }()
    
    private var startAngle = CGFloat.pi
    private var endAngle = CGFloat.pi * 4
    
    private let spinningView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinningView.backgroundColor = backgroundColor
        spinningView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(22)
        }
        spinningView.layer.cornerRadius = spinningView.frame.height / 2
        shapeLayer.path = UIBezierPath(
            arcCenter: .zero,
            radius: (spinningView.bounds.width - shapeLayer.lineWidth) / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        ).cgPath
        shapeLayer.position = CGPoint(x: spinningView.bounds.midX, y: spinningView.bounds.midY)
    }
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 16
        shapeLayer.frame = bounds
        shapeLayer.strokeColor = Theme.shared.darkGrayColor.withAlphaComponent(0.38).cgColor
        spinningView.layer.addSublayer(shapeLayer)
        addSubview(spinningView)
        spinningView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(22)
        }
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = CGFloat.zero
        animation.toValue = CGFloat.pi * 2
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.repeatCount = .greatestFiniteMagnitude
        spinningView.layer.add(animation, forKey: nil)
    }
}
