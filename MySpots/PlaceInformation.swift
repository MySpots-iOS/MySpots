//
//  PlaceInformationView.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-17.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit

class PlaceInformation: UIView {
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var distanceIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizesSubviews = false
        loadXibView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadXibView() {
        let view = Bundle.main.loadNibNamed( "PlaceInformation", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.placeName.textColor = UIColor.mainDarkGreen()
        self.distanceIcon.isUserInteractionEnabled = true
        self.addSubview(view)
    }
    
    func setSelectedPlaceName(_ name:String) {
        placeName.text = name
    }
    
    func setSelectedAddress(_ address: String) {
        addressName.text = address
    }
    
}
