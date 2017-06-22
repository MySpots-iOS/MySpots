//
//  CustomTableViewCell.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-20.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    var saved: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.placeName.textColor = UIColor.mainDarkGreen()
        self.imageIcon.isUserInteractionEnabled = true
        self.imageIcon.image = UIImage(named: "savedFolder")
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        tapImageGesture.delegate = self
        self.imageIcon.addGestureRecognizer(tapImageGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSpotSaved(_ flag: Bool) {
        saved = flag
    }
    
    func getSpotdSaved() -> Bool {
        return self.saved
    }
    
    func tappedImage(_ sender: UITapGestureRecognizer) {
        print("image tap")
    }
}
