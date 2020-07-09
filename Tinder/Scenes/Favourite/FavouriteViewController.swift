//
//  FavouriteViewController.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import UIKit

protocol FavouriteDisplayLogic {
    func favouriteError(_ error: String)
    func favouriteUser(_ users:[FavUsers]?)
}

class FavouriteViewController: BaseVC, UITableViewDataSource , UITableViewDelegate {
    var interactor:FavBusinessLogic?
    @IBOutlet weak var emptyView: EmptyView!
    @IBOutlet weak var tableView: UITableView!
    let cellID = "FavouriteTableViewCell"
    var users = [FavUsers]()

    @IBAction func swipeUser(_ sender: UIButton) {
        self.navigationController?.pushViewController(SwipeViewController(), animated: true)
    }
    
    // MARK:- Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupDependencyConfigurator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.addLoader(count: &loaderCount, isInteractionEnabled: false)
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "Favourite"
        let nib = UINib.init(nibName: cellID, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier:cellID)
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.favUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! FavouriteTableViewCell
        cell.user = self.users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//MARK:- Display logic
extension FavouriteViewController:FavouriteDisplayLogic {
    func favouriteUser(_ users: [FavUsers]?) {
        if let fav = users{
            self.users = fav
        }
        if(self.users.count == 0){
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
        }else{
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.emptyView.isHidden = true
        }
        Utilities.removeLoader(count: &loaderCount)
    }
    
    func favouriteError(_ error: String) {
        Utilities.removeLoader(count: &loaderCount)
    }
}

// MARK:- Configuration Logic
extension FavouriteViewController {
    fileprivate func setupDependencyConfigurator() {
        let interactor = FavouriteInteractor()
        let presenter = FavouritePresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
}
