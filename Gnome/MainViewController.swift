//
//  MainViewController.swift
//  Gnome
//
//  Created by Vladimir Spasov on 10/11/17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import ElongationPreview
import AlamofireImage


class MainViewController: ElongationViewController {

    var gnomes:[Gnome] = []
    var searchResults:[Gnome] = []

    var searchBar: UISearchBar!
    let toggleSearchBarButton: UIButton = UIButton(type: .custom)

    // MARK: Lifecycle 🌎
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func openDetailView(for indexPath: IndexPath) {
        let id = String(describing: DetailViewController.self)
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id) as? DetailViewController else { return }
        let gnome = searchResults[indexPath.row]
        detailViewController.title = gnome.name
        detailViewController.friends = gnome.friends!
        detailViewController.professions = gnome.professions!
        expand(viewController: detailViewController)
    }

    func fetchData(){
        let service = GnomeAPI()
        service.fetchGnomes { (result) in
            switch result {
            case .Success(let data):
                self.gnomes = data
                self.searchResults = data

                self.tableView.reloadData()
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }
    }

    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Setup ⛏
private extension MainViewController {

    func setup() {
        tableView.backgroundColor = UIColor.black
        tableView.registerNib(DemoElongationCell.self)

        navigationController?.isNavigationBarHidden = true
        toggleSearchBarButton.translatesAutoresizingMaskIntoConstraints = false

        setToggleSearchBarButton()
        setupSearchbar()
    }

    func setupSearchbar(){
        searchBar = UISearchBar(frame: CGRect(x: -view.frame.width, y: 20, width: view.frame.width, height: 40))

        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = UIColor.clear
        searchBar.tintColor = UIColor.white
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        searchBar.delegate = self
        searchBar.showsCancelButton = true


        let image = UIImage(named: "CancelSearch")?.af_imageScaled(to: CGSize(width: 22.0, height: 22.0))
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).image = image


        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = nil

        view.addSubview(searchBar)
    }

    func setToggleSearchBarButton(){
        if let image = UIImage(named: "SearchIcon") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            toggleSearchBarButton.setImage(tintedImage, for: .normal)
        }

        toggleSearchBarButton.translatesAutoresizingMaskIntoConstraints = false
        toggleSearchBarButton.addTarget(self, action: #selector(self.showSearchBar), for: .touchUpInside)
        toggleSearchBarButton.tintColor = UIColor.white

        view.addSubview(toggleSearchBarButton)

        toggleSearchBarButton.frame = CGRect(x: view.frame.width-42.0, y: 31, width: 22.0, height: 22.0)
    }

    @objc func showSearchBar(){
        UIView.animate(withDuration: 0.5) {
            self.searchBar.frame.origin.x += self.view.frame.width
            self.toggleSearchBarButton.alpha = 0
        }
        searchBar.becomeFirstResponder()
    }
}



// MARK: - TableView 📚
extension MainViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DemoElongationCell.self)
        return cell
    }
}

extension MainViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        guard let cell = cell as? DemoElongationCell else { return }

        let gnome = searchResults[indexPath.row]

        cell.setUpWith(gnome: gnome)
    }
}


// MARK: - UISearchBarDelegate 🔍
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchResults = gnomes.filter { ($0.name?.hasPrefix(searchText))! }
            self.tableView.reloadData(with: .fade)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        UIView.animate(withDuration: 0.5) { 
            self.searchBar.frame.origin.x -= self.view.frame.width
            self.toggleSearchBarButton.alpha = 1
            self.searchBar.resignFirstResponder()
        }
    }
}

// MARK: - ScrollView 🔍
extension MainViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        toggleSearchBarButton.transform = CGAffineTransform(translationX: 0, y: self.tableView.contentOffset.y)
        searchBar.transform = CGAffineTransform(translationX: 0, y: self.tableView.contentOffset.y)
    }
}



