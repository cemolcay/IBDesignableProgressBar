//
//  IBDesignableProgressBar.swift
//  IBDesignableProgressBar
//
//  Created by Cem Olcay on 23/06/16.
//  Copyright © 2016 Prototapp. All rights reserved.
//

import UIKit

@IBDesignable
open class IBDesignableProgressBar: UIView {
  // Paddings
  @IBInspectable open var topPadding: CGFloat = 0
  @IBInspectable open var leftPadding: CGFloat = 0
  @IBInspectable open var rightPadding: CGFloat = 0
  @IBInspectable open var bottomPadding: CGFloat = 0

  // Frame
  @IBInspectable open var cornerRadius: CGFloat = 10
  @IBInspectable open var borderColor: UIColor = UIColor.black
  @IBInspectable open var borderWidth: CGFloat = 1
  @IBInspectable open var fillColor: UIColor = UIColor.white

  // Bar
  @IBInspectable open var barColor: UIColor = UIColor.gray

  /// Value of progress bar in [0, 1] range.
  @IBInspectable open var value: CGFloat = 0 {
    didSet {
      if value < 0 {
        value = 0
      } else if value > 1 {
        value = 1
      }
    }
  }

  fileprivate var frameLayer: CALayer = CALayer()
  fileprivate var barLayer: CALayer = CALayer()

  // MARK: Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
    defaultInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    defaultInit()
  }

  fileprivate func defaultInit() {
    layer.addSublayer(frameLayer)
    frameLayer.addSublayer(barLayer)
  }

  // MARK: Layout
  open override func layoutSubviews() {
    super.layoutSubviews()

    var rect = CGRect(
      x: max(0, leftPadding),
      y: max(0, topPadding),
      width: max(0, frame.size.width - (leftPadding + rightPadding)),
      height: max(0, frame.size.height - (topPadding + bottomPadding)))

    // Frame
    frameLayer.frame = rect
    frameLayer.cornerRadius = cornerRadius
    frameLayer.backgroundColor = fillColor.cgColor
    frameLayer.borderColor = borderColor.cgColor
    frameLayer.borderWidth = borderWidth
    frameLayer.masksToBounds = true

    // Bar
    rect.origin = CGPoint.zero
    rect.size.width = rect.size.width * value
    barLayer.frame = rect
    barLayer.backgroundColor = barColor.cgColor
  }
}
