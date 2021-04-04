import Foundation

protocol LoginViewDelegate: class {
    func loginDidSucceed(user: UserModel)
    func loginDidFailed(message: String)
}

class LoginPresenter  {

    weak var viewDelegate: LoginViewDelegate?
    let bankAPI: BankAPI

    init(bankAPI: BankAPI) {
        self.bankAPI = bankAPI
    }

    func setViewDelegate(viewDelegate: LoginViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    func login(user: String, password: String) {

        bankAPI.login(user: user, password: password) { [weak self] result in
                DispatchQueue.main.async {
                switch result {
                case .success(let loginResponse):
                    if let errorResponse = loginResponse.error {
                        self?.viewDelegate?.loginDidFailed(message: errorResponse.message)
                    } else {
                        UserDefaults.standard.set(loginResponse.userAccount?.userId, forKey: "userId")
                        self?.viewDelegate?.loginDidSucceed(user: loginResponse.userAccount!)
                    }
                case .failure:
                    self?.viewDelegate?.loginDidFailed(message:  "")
                }
            }

        }
    }
}
