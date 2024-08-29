//
//  View.swift
//  CryptoCrazy-VIPER
//
//  Created by Sabri Çetin on 26.08.2024.
//


import Foundation
import UIKit

// Talks to  -> presenter
// Class , Protocol
// ViewController

protocol AnyView {
    
    var presnter : AnyPresenter? { get set }
    func update (with cryptos: [Crypto])
    func update (with error : String)
    
}
class DetailViewController : UIViewController {
    var currency : String = ""
    var price : String = ""
    
    private let currencyLabel: UILabel = {
    let label = UILabel()
        label.isHidden = false
        label.text = "currency Label"
        label.textColor = .black
        label.layer.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        label.textAlignment = .center
 return label
    }()
    
    private let priceLabel: UILabel = {
    let label = UILabel()
        label.isHidden = false
        label.text = "Price Label "
        label.textColor = .black
        label.layer.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        label.textAlignment = .center
 return label
    }()
    
    override func   viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencyLabel.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height / 2 - 150, width: 300, height: 60)
        priceLabel.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height / 2 - 50, width: 300, height: 60)
        
        currencyLabel.text = currency
        priceLabel.text = price
        
        currencyLabel.isHidden = false
        priceLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    let gradientBack1 = CAGradientLayer()
        gradientBack1.frame = view.bounds
        
        // Gradyan renklerini belirliyoruz
        gradientBack1.colors = [UIColor(hex: "ef67c3").cgColor, UIColor(hex: "#31c6e4").cgColor]
            
        // Gradyan yönünü belirliyoruz
        gradientBack1.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientBack1.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Gradyan katmanını view'un katmanına ekliyoruz
        view.layer.insertSublayer(gradientBack1, at: 0)
        view.addSubview(currencyLabel)
        view.addSubview(priceLabel)
    }
}

class CryptoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presnter: AnyPresenter?
    var cryptos: [Crypto] = []
    
    private let tableView: UITableView = {
    let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
 return table
    }()
    
    private let massageLabel: UILabel = {
    let label = UILabel()
        label.isHidden = false
        label.text = "Downloading . . ."
        label.textColor = .red
        label.layer.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gradyan katmanı oluşturuyoruz
        let gradientBack = CAGradientLayer()
            gradientBack.frame = view.bounds
            
            // Gradyan renklerini belirliyoruz
        
            gradientBack.colors = [UIColor(hex: "ef67c3").cgColor,UIColor(hex: "#31c6e4").cgColor ]
        
            // Gradyan yönünü belirliyoruz
        
            gradientBack.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientBack.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            // Gradyan katmanını view'un katmanına ekliyoruz
            view.layer.insertSublayer(gradientBack, at: 0)
        
    let gradientView = UIView(frame: view.bounds)
    let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: "ef67c3").cgColor,UIColor(hex: "#31c6e4").cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = gradientView
        
        view.addSubview(tableView)
        view.addSubview(massageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        massageLabel.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height / 2 - 50, width: 300, height: 60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.textProperties.color = .white
        content.secondaryText = cryptos[indexPath.row].price
        content.secondaryTextProperties.color = .black
        cell.contentConfiguration = content
        
        // Gradyan katmanı oluşturuyoruz
        
    let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [UIColor(hex: "#31c6e4").cgColor ,UIColor(hex: "#ef67c3").cgColor , ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        // Gradyan katmanını hücrenin backgroundView'ına ekliyoruz
    let backgroundView = UIView(frame: cell.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        cell.backgroundView = backgroundView
        
        return cell
    }
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.massageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.massageLabel.text = error
            self.massageLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController()
        nextViewController.currency = cryptos[indexPath.row].currency
        nextViewController.price = cryptos[indexPath.row].price
        self.present(nextViewController, animated: true, completion: nil)
    }
}
