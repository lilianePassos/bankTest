struct UserModel: Codable {
    let userId: Int
    let name: String
    let bankAccount: String
    let agency: String
    let balance: Double

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case name = "name"
        case bankAccount = "bankAccount"
        case agency = "agency"
        case balance = "balance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decode(Int.self, forKey: .userId)
        name = try values.decode(String.self, forKey: .name)
        bankAccount = try values.decode(String.self, forKey: .bankAccount)
        agency = try values.decode(String.self, forKey: .agency)
        balance = try values.decode(Double.self, forKey: .balance)

    }
}

struct LoginResponse: Codable {
    let userAccount: UserModel?
    let error: ErrorApi?

    enum CodingKeys: String, CodingKey {
        case userAccount = "userAccount"
        case error = "error"
    }

    init(userAccount: UserModel?, error: ErrorApi?) {
        self.userAccount = userAccount
        self.error = error
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userAccount = try? values.decode(UserModel.self, forKey: .userAccount)
        error = try? values.decode(ErrorApi.self, forKey: .error)
    }
}
