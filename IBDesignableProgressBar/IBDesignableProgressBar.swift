//
//  IBDesignableProgressBar.swift
//  IBDesignableProgressBar
//
//  Created by Cem Olcay on 23/06/16.
//  Copyright © 2016 Prototapp. All rights reserved.
//

import UIKit

@IBDesignable
public class IBDesignableProgressBar: UIView {
  // Paddings
  @IBInspectable public var topPadding: CGFloat = 0
  @IBInspectable public var leftPadding: CGFloat = 0
  @IBInspectable public var rightPadding: CGFloat = 0
  @IBInspectable public var bottomPadding: CGFloat = 0

  // Frame
  @IBInspectable public var cornerRadius: CGFloat = 10
  @IBInspectable public var borderColor: UIColor = UIColor.blackColor()
  @IBInspectable public var borderWidth: CGFloat = 1
  @IBInspectable public var fillColor: UIColor = UIColor.whiteColor()

  // Bar
  @IBInspectable public var barColor: UIColor = UIColor.grayColor()

  /// Value of progress bar in [0, 1] range.
  @IBInspectable public var value: CGFloat = 0 {
    didSet {
      if value < 0 {
        value = 0
      } else if value > 1 {
        value = 1
      }
    }
  }

  private var frameLayer: CALayer = CALayer()
  private var barLayer: CALayer = CALayer()

  // MARK: Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
    defaultInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    defaultInit()
  }

  private func defaultInit() {
    layer.addSublayer(frameLayer)
    frameLayer.addSublayer(barLayer)
  }

  // MARK: Layout
  public override func layoutSubviews() {
    super.layoutSubviews()

    var rect = CGRect(
      x: max(0, leftPadding),
      y: max(0, topPadding),
      width: max(0, frame.size.width - (leftPadding + rightPadding)),
      height: max(0, frame.size.height - (topPadding + bottomPadding)))

    // Frame
    frameLayer.frame = rect
    frameLayer.cornerRadius = cornerRadius
    frameLayer.backgroundColor = fillColor.CGColor
    frameLayer.borderColor = borderColor.CGColor
    frameLayer.borderWidth = borderWidth
    frameLayer.masksToBounds = true

    // Bar
    rect.origin = CGPoint.zero
    rect.size.width = rect.size.width * value
    barLayer.frame = rect
    barLayer.backgroundColor = barColor.CGColor
  }
}
