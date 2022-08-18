//
//  View.swift
//  CryptoWithVIPER
//
//  Created by Hasan Kaya on 18.08.2022.
//

import Foundation
import UIKit

// talks to Presenter
// Class, Protocol
// ViewController

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto])
    func update(with error: String)
}
class CryptoViewController: UIViewController, AnyView ,UITableViewDelegate,UITableViewDataSource{
    
    var cryptos : [Crypto] = []
    
    var presenter: AnyPresenter?
    private let tableView : UITableView =  {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        table.isMultipleTouchEnabled = false
        return table
    }()
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "Downloading... "
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        view.backgroundColor = .tintColor
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50 )
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].name
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .tintColor
        
        return cell
    }
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        self.cryptos = []
        self.tableView.isHidden = true
        self.messageLabel.text = error
        self.messageLabel.isHidden = false
    }
    
    
}
