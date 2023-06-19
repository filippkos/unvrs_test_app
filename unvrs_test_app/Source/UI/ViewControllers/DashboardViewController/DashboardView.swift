//
//  DashboardView.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

enum DashboardViewOutputEvents {
    
    case showTermsOfUseAndPrivacyPolicy
    case showSubscriptionTerms
}

enum TermsMessagePart {
    
    public static let first = "By continuing you accept our:\n"
    public static let second = "Terms of Use, Privacy Policy "
    public static let third = "and "
    public static let fourth = "Subscription Terms"
}

class DashboardView: UIView, UITextViewDelegate {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var button: UIButton?
    @IBOutlet var pager: PagerView?
    @IBOutlet var termsView: UITextView?
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((DashboardViewOutputEvents) -> ())?
    
    private let cellHorizontalInsets: CGFloat = 31
    private let spacingBetweenCells: CGFloat = 16
    
    // MARK: -
    // MARK: Public

    public func configure(outputEvents: ((DashboardViewOutputEvents) -> ())?) {
        self.outputEvents = outputEvents
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png") ?? UIImage())
        self.termsView?.delegate = self
        self.updateTermsMessage(visibility: true)
        self.configureButton()
        self.configureTermsView()
        self.flowLayoutConfigure()
    }
    
    public func configurePager() {
        let offsetStep = self.frame.width - (self.cellHorizontalInsets * 2) + self.spacingBetweenCells
        let xPosition = (self.collectionView?.contentOffset.x ?? 0) + offsetStep
        let dividend = xPosition / offsetStep
        let rounded = Int(round(dividend))
        let index = rounded - 1
        self.pager?.updateViews(number: index)
        self.handleTermsMessageVisibility()
    }

    // MARK: -
    // MARK: Private
    
    private func configureButton() {
        self.button?.setTitle("Continue", for: .normal)
        self.button?.tintColor = .black
    }
    
    private func handleTermsMessageVisibility() {
       self.pager?.actualPage == 0 || self.pager?.actualPage == 3 ? self.updateTermsMessage(visibility: true) : self.updateTermsMessage(visibility: false)
    }
    
    private func flowLayoutConfigure() {
        let itemWidth = UIScreen.main.bounds.width - (self.cellHorizontalInsets * 2)
        let itemHeight = self.collectionView?.frame.size.height
        let layout = PagingCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: self.cellHorizontalInsets,
            bottom: 0,
            right: self.cellHorizontalInsets
        )
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight ?? 0)
        layout.minimumLineSpacing = self.spacingBetweenCells
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = false
    }
    
    private func updateTermsMessage(visibility: Bool) {
        self.termsView?.alpha = visibility ? 1 : 0
        self.pager?.alpha = visibility ? 0 : 1
    }
    
    private func configureTermsView() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 18

        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "TextViewGray") as Any,
            .font: UIFont(name: "SF Pro Display Regular", size: 12) as Any,
            .paragraphStyle: paragraphStyle
        ]
        let termsOfUseAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "TextViewBlue") as Any,
            .font: UIFont(name: "SF Pro Display Regular", size: 12) as Any,
            .paragraphStyle: paragraphStyle,
            .link: "http://use"
        ]
        let subscriptionTermsAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "TextViewBlue") as Any,
            .font: UIFont(name: "SF Pro Display Regular", size: 12) as Any,
            .paragraphStyle: paragraphStyle,
            .link: "http://subscription"
        ]

        let firstPart = NSMutableAttributedString(
            string: TermsMessagePart.first,
            attributes: textAttributes
        )
        let secondPart = NSMutableAttributedString(
            string: TermsMessagePart.second,
            attributes: termsOfUseAttributes
        )
        let thirdPart = NSMutableAttributedString(
            string: TermsMessagePart.third,
            attributes: textAttributes
        )
        let fourthPart = NSMutableAttributedString(
            string: TermsMessagePart.fourth,
            attributes: subscriptionTermsAttributes
        )
        self.termsView?.attributedText = self.setTextFrom(values: [firstPart, secondPart, thirdPart, fourthPart])
    }
    
    private func setTextFrom(values: [NSAttributedString]) -> NSAttributedString {
        let result = NSMutableAttributedString()

        values.forEach {
            result.append($0)
        }

        return result
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.button?.layer.cornerRadius = (self.button?.frame.height ?? CGFloat()) / 2
    }
    
    // MARK: -
    // MARK: UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        URL.description == "http://subscription"
            ? self.outputEvents?(.showSubscriptionTerms)
            : self.outputEvents?(.showTermsOfUseAndPrivacyPolicy)
        
        return false
    }
}
