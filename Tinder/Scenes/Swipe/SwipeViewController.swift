//
//  SwipeViewController.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import UIKit

protocol UserDisplayLogic {
    func displayError(_ error: String)
    func showUser(_ user:UserList.FetchUsers.ViewModel.DisplayedUser)

}

class SwipeViewController: BaseVC , SelectItem{
    var divisor:CGFloat!
    @IBOutlet weak var errorMessage: ErrorMessage!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userHeading: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var menubar: MenuBar!
    let marginToVanish:CGFloat = 75
    var user:UserList.FetchUsers.ViewModel.DisplayedUser?
    var interactor:SwipeBusinessLogic?
    
    // MARK:- Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setupDependencyConfigurator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencyConfigurator()

        menubar.delegate = self
        loadCard()
        card.dropShadow()
        divisor = (view.frame.width/2)/0.61
        self.title = "Random Persons"
        self.errorMessage.delegate = self
        
    }
    
    func loadCard(){
        Utilities.addLoader(count: &loaderCount, isInteractionEnabled: false)
        interactor?.fetchUser()
    }
    
    func saveUser(){
        saveFavUser(user: user)
    }
    
    @IBAction func swapGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let scale = min(100/abs(xFromCenter),1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        //bring to center
        if sender.state == UIGestureRecognizer.State.ended{
            //margin off the screen
            if(Int(card.center.x) < Int(marginToVanish)){
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y  + self.marginToVanish)
                    card.alpha = 0
                }
                self.loadCard()
                return
            }else if(card.center.x > (self.view.frame.width - marginToVanish) ){
                //move off the right side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y  + self.marginToVanish)
                    card.alpha = 0
                }
                self.saveUser()
                self.loadCard()
                return
            }
            
        }
        if sender.state == UIGestureRecognizer.State.ended{
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                card.center.y = card.frame.size.height / 2 + 12
                card.transform = .identity
            }
        }
    }
    
    func loadData(){
        DispatchQueue.main.async {
            self.profilePic.image = nil
            if let profileURL = URL(string:self.user?.profilePic ?? ""){
                self.profilePic.load(url: profileURL)
            }
            self.menubar.collectionView.delegate?.collectionView?( self.menubar.collectionView, didSelectItemAt: IndexPath(item: 2, section: 0))
            self.menubar.collectionView.reloadData()
            self.card.alpha = 1
            self.card.center = self.view.center
            self.card.transform = .identity
        }
    }
    
    
}


//MARK:- Display logic
extension SwipeViewController:UserDisplayLogic {
    
    func displayError(_ error: String){
        Utilities.removeLoader(count: &loaderCount)
        resetFormFields()
        self.errorMessage.isHidden = false
        self.card.isHidden = true
    }
    
    func showUser(_ user:UserList.FetchUsers.ViewModel.DisplayedUser){
        self.user = user
        Utilities.removeLoader(count: &loaderCount)
        self.errorMessage.isHidden = true
        self.card.isHidden = false
        loadData()
    }
}

// MARK:- Configuration Logic
extension SwipeViewController {
    fileprivate func setupDependencyConfigurator() {
        let interactor = SwipeInteractor()
        let presenter = SwipePresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
}

extension SwipeViewController:ReConnect{
   func reConnect(){
        loadCard()
    }
}
