//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Matsulenko on 18.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        view.backgroundColor = .systemGray4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
                
    }
    
    override func viewWillLayoutSubviews() {
        let profileHeaderView = ProfileHeaderView()
            profileHeaderView.frame = CGRect(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
        view.addSubview(profileHeaderView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
