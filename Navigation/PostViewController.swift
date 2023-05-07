import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        let infoViewController = InfoViewController()

        infoViewController.title = "Инфо"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(buttonPressed(_:)))

        view.backgroundColor = .systemGray4
    }

    @objc func buttonPressed(_ sender: UIBarButtonItem) {

        let infoViewController = InfoViewController()

        present(infoViewController, animated: true)
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
