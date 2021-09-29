//
//  MainConfigurator.swift
//  MovieApp
//
//  Created by Vladislav Nikolaychuk on 29.09.2021.
//

import UIKit

class MainConfigurator {
    func create() -> UIViewController {
        let view = MainViewController()
        let interactor: MainInteractorProtocol = MainInteractor()
        let presenter: MainPresenterProtocol = MainPresenter()
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        return view
    }
}
