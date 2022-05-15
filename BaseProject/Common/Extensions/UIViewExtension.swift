//
//  UIViewExtension.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    var isShow: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }

    func addShadowView(withColor color: UIColor) {
        self.layer.applySketchShadow(color: color, alpha: 0.11, xLocation: 0, yLocation: 20, blur: 40, spread: 7)

    }

    func makeRounded(radius: CGFloat,
                     corners: UIRectCorner,
                     frame: CGRect? = nil,
                     borderWidth: CGFloat = 0,
                     borderColor: UIColor? = nil) {
        if let frame = frame {
            self.bounds = frame
        }
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath

        if borderWidth > 0 {
            let borderLayer = CAShapeLayer()
            borderLayer.path = maskPath1.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor?.cgColor ?? UIColor.lightGray.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor

            layer.addSublayer(borderLayer)
        }

        layer.mask = maskLayer1
    }

}

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.11,
    xLocation: CGFloat = 0,
    yLocation: CGFloat = 20,
    blur: CGFloat = 40,
    spread: CGFloat = 7) {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: xLocation, height: yLocation)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dxLocation = -spread
      let rect = bounds.insetBy(dx: dxLocation, dy: dxLocation)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}

extension UIView {

    static func fromNib( ) -> Self {
        func impl<Type: UIView>( type: Type.Type ) -> Type {
            return Bundle.main.loadNibNamed(String(describing: type), owner: nil, options: nil)!.first as! Type
        }

        return impl(type: self)
    }

    func addShadow(shadowColor: UIColor,
                   offSet: CGSize,
                   opacity: Float,
                   shadowRadius: CGFloat,
                   cornerRadius: CGFloat,
                   corners: UIRectCorner,
                   fillColor: UIColor = .clear) {

        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath // 1
        shadowLayer.path = cgPath // 2
        shadowLayer.fillColor = fillColor.cgColor // 3
        shadowLayer.shadowColor = shadowColor.cgColor // 4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet // 5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }

    open func generateOuterShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, backgroundColor: UIColor = UIColor.white) {

        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offSet
        self.clipsToBounds = true

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = layer.cornerRadius
        view.layer.shadowRadius = layer.shadowRadius
        view.layer.shadowOpacity = layer.shadowOpacity
        view.layer.shadowColor = layer.shadowColor
        view.layer.shadowOffset = layer.shadowOffset
        view.clipsToBounds = false
        view.backgroundColor = backgroundColor
        superview?.insertSubview(view, belowSubview: self)
        let constraints = [
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ]

        superview?.addConstraints(constraints)
    }

    open func generateShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat) -> UIView {

        layer.cornerRadius = cornerRadius
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offSet
        self.clipsToBounds = true

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = layer.cornerRadius
        view.layer.shadowRadius = layer.shadowRadius
        view.layer.shadowOpacity = layer.shadowOpacity
        view.layer.shadowColor = layer.shadowColor
        view.layer.shadowOffset = layer.shadowOffset
        view.clipsToBounds = false
        view.backgroundColor = .white
        superview?.insertSubview(view, belowSubview: self)
        let constraints = [
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ]

        superview?.addConstraints(constraints)
        return view
    }

}
extension UIView {

    /**
     Removes all constrains for this view
     */
    func removeConstraints() {

        let constraints = self.superview?.constraints.filter {
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []

        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
}
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIView {
    func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
        layer.anchorPoint = anchorPoint
        let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
        let xPadding = 1/scale * (anchorPoint.x - 0.5)*bounds.width
        let yPadding = 1/scale * (anchorPoint.y - 0.5)*bounds.height
        transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
    }
}

extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}
