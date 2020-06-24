//
//  PlaceholderTextView.swift
//  VPhone
//
//  Created by TuanHA-D1 on 3/12/20.
//

import Foundation
import UIKit

class PlaceholderTextView: CustomNibView {
    // MARK: - OUTLET
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var leftConstraintPlaceholder: NSLayoutConstraint!
    @IBOutlet weak var topConstraintPlaceholder: NSLayoutConstraint!
    @IBOutlet weak var rightConstraintPlaceholder: NSLayoutConstraint!
    
    // MARK: - VARIABLE
    var padding: UIEdgeInsets? {
        didSet {
            self.textView.textContainerInset = UIEdgeInsets(top: padding?.top ?? 14, left: padding?.left ?? 14, bottom: padding?.bottom ?? 14, right: padding?.right ?? 14)
            self.leftConstraintPlaceholder.constant = (padding?.left ?? 14) + 5
            self.topConstraintPlaceholder.constant = (padding?.top ?? 14) - 1
            self.rightConstraintPlaceholder.constant = padding?.right ?? 14
        }
    }
     
    lazy var text: String? = textView.text
    
    var textColor: UIColor? {
        didSet {
            textView.textColor = self.textColor ?? UIColor.black
        }
    }
    
    var fontSize: CGFloat? {
        didSet {
            self.textView.font = .systemFont(ofSize: self.fontSize ?? 16)
            self.placeholderLabel.font = .systemFont(ofSize: self.fontSize ?? 16)
        }
    }
    
    var placeholder: String? {
        didSet {
            self.placeholderLabel.text = self.placeholder ?? ""
        }
    }
    
    var placeholderColor: UIColor? {
        didSet {
            self.placeholderLabel.textColor = placeholderColor ?? UIColor(hex: "BEBEBE")
        }
    }
    
    var colorBackground: UIColor? {
        didSet {
            self.contentView.backgroundColor = self.colorBackground ?? UIColor.white
        }
    }
    
    var roundCorner: CGFloat? {
        didSet {
            self.contentView.layer.cornerRadius = self.roundCorner ?? 0
        }
    }
    
    var heightDidChange: ((_ height: CGFloat) -> Void)?
    
    override func setup() {
        super.setup()
        setupView()
    }
    
    private func setupView() {
        placeholderLabel.isHidden = false
        textView.delegate = self
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.textView {
            self.placeholderLabel.isHidden = textView.text.isEmpty ? false : true
            let fixedWidth = textView.frame.size.width
            textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            self.heightDidChange?(newFrame.height)
        }
    }
}
