//
//  DetailViewController.swift
//  Gnome
//
//  Created by Vladimir Spasov on 10/11/17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import ElongationPreview


class DetailViewController: ElongationDetailViewController {

    var friends : [String] = []
    var professions : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.separatorStyle  = .none
        tableView.registerNib(GridViewCell.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(GridViewCell.self)
        cell.friendsLabel.text = friends.joined(separator:", ")
        cell.friendsLabel.sizeToFit()
        cell.professionsLabel.text = professions.joined(separator:", ")
        cell.professionsLabel.sizeToFit()

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let appearance = ElongationConfig.shared
        let headerHeight = appearance.topViewHeight + appearance.bottomViewHeight
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight - headerHeight
    }
    
}
