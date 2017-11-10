//
//  DemoElongationCell.swift
//  Gnome
//
//  Created by Vladimir Spasov on 10/11/17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import ElongationPreview


class DemoElongationCell: ElongationCell {
  
  @IBOutlet var topImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!

  
  @IBOutlet var topImageViewTopConstraint: NSLayoutConstraint!

    func setUpWith(gnome: Gnome){

        self.topImageView.af_setImage(withURL: URL(string: gnome.thumbnail!.replacingOccurrences(of: "http", with: "https"))!)

        self.nameLabel?.text = gnome.name?.uppercased()
        self.ageLabel.text = String(describing: gnome.age!)
        self.heightLabel.text = String(describing: gnome.height!)
        self.weightLabel.text = String(describing: gnome.weight!)
        self.hairColorLabel.text = gnome.hairColor
    }
  
}
