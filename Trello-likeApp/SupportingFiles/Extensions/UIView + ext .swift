//
//  UIView+Extensions .swift
//  WeekActivityTestCell
//
//  Created by Mikhail Ustyantsev on 14.02.2023.
//

import UIKit

extension UIView {
    
    enum Edge {
        case left
        case top
        case right
        case bottom
    }
    
    func pinToSuperviewEdges(_ edges: [Edge] = [.top, .bottom, .left, .right], constant: CGFloat = 0) {
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .top: topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .left:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            case .right:
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
    
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    
    func addBottomBorder(with color: UIColor, height: CGFloat, edgeOffset: CGFloat = 0) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: edgeOffset,
                                 y: frame.height - height,
                                 width: frame.width - (edgeOffset * 2),
                                 height: height)
        addSubview(separator)
    }
    
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        
        button.addTarget(self, action: #selector(handleOut), for: [
            .touchDragOutside,
            .touchUpInside,
            .touchUpOutside,
            .touchDragExit,
            .touchCancel
        ])
    }
    
    @objc func handleIn() {
        UIView.animate(withDuration: 0.15) { self.alpha = 0.55 }
    }
    
    @objc func handleOut() {
        UIView.animate(withDuration: 0.15) { self.alpha = 1 }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = bounds
        borderLayer.path = path.cgPath
        borderLayer.strokeColor = R.Colors.lightGray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1
        layer.addSublayer(borderLayer)
    }
    
}
