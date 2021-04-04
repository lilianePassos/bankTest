import UIKit

class LoginViewController : UIViewController, LoginViewDelegate {
    func loginDidSucceed(user: UserModel) {
        let destination = StatementViewController.fromNib()!
        destination.userModel = user
        self.navigationController?.pushViewController(destination, animated: true)
    }

    func loginDidFailed(message: String) {
        print(message)
    }

    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let presenter = LoginPresenter(bankAPI: BankHTTP())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(viewDelegate: self)
        self.userTextField.text = "test_user"
        self.passwordTextField.text = "Test@1"
    }

    @IBAction func login(_ sender: Any) {

        guard let user = userTextField.text, let password = passwordTextField.text
        else  {
            // aler preencha todos os campos
            return
        }
        presenter.login(user: user, password: password)
    }
}
