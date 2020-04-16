//
//  FloatingActionButton.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/15.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButton {

  private let nibName = FloatingActionButton.className
  
  @IBOutlet weak var button: UIButton!
  
  var actionToPerform: (() -> Void)?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  private func commonInit() {
    
    guard let view = loadViewFromNib() else { return }
    view.frame = self.bounds
    self.addSubview(view)
    
    button.setUpDropShadow(opacity: 0.5)
    button.setUpCornerRadiusWith(radiusOf: 25)
    
  }
  
  private func loadViewFromNib() -> UIView? {
    
    let nib = UINib(nibName: nibName, bundle: nil)
    return nib.instantiate(withOwner: self, options: nil).first as? UIView
    
  }
  
  @IBAction func buttonPressed(_ sender: Any) {
    actionToPerform?()
  }

}
