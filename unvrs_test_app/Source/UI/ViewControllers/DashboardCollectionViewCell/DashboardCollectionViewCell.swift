//
//  DashboardCollectionViewCell.swift
//  unvrs_test_app
//
//  Created by Filipp Kosenko on 05.06.2023.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var container: UIView?
    
    // MARK: -
    // MARK: Variables
    
    var index: Int = 0
    
    // MARK: -
    // MARK: Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.configureUI()
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureUI() {
        self.container?.layer.cornerRadius = 20
        self.container?.layer.masksToBounds = true
        self.titleLabel?.font = UIFont(name: "SF Pro Display Bold", size: 26)
        self.titleLabel?.textColor = .white
        
        self.descriptionLabel?.font = UIFont(name: "SF Pro Display Medium", size: 17)
        self.descriptionLabel?.textColor = .white
        self.prepareBlurView()
    }
    
    private func prepareBlurView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.backgroundColor = UIColor(hue: 0.6, saturation: 0.8, brightness: 0.5, alpha: 0.24)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
    }
    
    public func configure(model: DashboardContentModel, index: Int) {
        self.index = index
        self.imageView?.image = model.image
        self.titleLabel?.text = model.title
        self.descriptionLabel?.text = model.description
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        self.layer.cornerRadius = 20
    }

}
