//
//  ViewController.swift
//  FullScreenSwiping
//
//  Created by Q on 2022-06-30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = ColorsCollectionViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }

}

