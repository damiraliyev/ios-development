import UIKit

class AccountSummaryViewController: UIViewController{
    
    //Request models
    var profile: Profile?
    var accounts: [Account] = []
    
    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    let tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension AccountSummaryViewController{
    private func setup(){
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView(){
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = CGFloat(AccountSummaryCell.rowHeight)
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupSkeletons(){
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
    }
    
//    private func setupHeaderView(){
//        let header = AccountSummaryHeaderView(frame: .zero)
//        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//        size.width = UIScreen.main.bounds.width
//        header.frame.size = size
//
//        tableView.tableHeaderView = header
//    }
}
extension AccountSummaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell()}
        let account = accountCellViewModels[indexPath.row]
        
        if isLoaded{
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
}


extension AccountSummaryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
//        let userId = String(Int.random(in: 1..<4))
        group.enter()
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main){
            self.tableView.refreshControl?.endRefreshing()
            
            guard let profile = self.profile else{ return }
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
            self.isLoaded = true
            
            self.tableView.reloadData()
        }
        
        
    }
    private func configureTableCells(with accounts: [Account]) {
            accountCellViewModels = accounts.map {
                AccountSummaryCell.ViewModel(accountType: $0.type,
                                             accountName: $0.name,
                                             balance: $0.amount)
            }
        }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    private func displayError(_ error: NetworkError){
        let title: String
        let message: String
        switch error{
        case .serverError:
            title = "Server Error"
            message = "Ensure that you are connected to the Internet.Please,try again."
        case .decodingError:
            title = "Decoding Error"
            message = "We couldn't process your request. Please,try again."
        }
        self.showErrorAlert(title: title, message: message)
    }
    
    private func showErrorAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: Action

extension AccountSummaryViewController{
    @objc func logoutTapped(){
        NotificationCenter.default.post(name: NSNotification.Name.logout, object: nil)
    }
    
    @objc func refreshContent(){
        reset()
        fetchData()
        setupSkeletons()
        tableView.reloadData()
    }
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}

