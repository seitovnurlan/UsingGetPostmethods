//
//  GetRequestPage.swift
//  UsingGetPostmethods
//
//  Created by Nurlan Seitov on 2/4/23.
//
import Foundation
import UIKit
import SnapKit
import Kingfisher

class GetRequestPage: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    } ()
    
//    private var tableView = UITableView()
    var data: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableViewConfigue()
        setupViewConstraints()

    }
    private func setupTableViewConfigue() {
        
        view.backgroundColor = .systemGray4
        
        title = "Some news"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    private func setupViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            // make.leading.trailing.top.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(65)
            make.bottom.equalTo(view.snp.bottom).inset(35)
            make.leading.trailing.equalToSuperview()
        }
    }
//        APIManager.shared.getData { [weak self] result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    guard let `self` else {return}
//                    self.timeData = data.articles ?? []
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    
}

extension GetRequestPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
      return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell
        let value = data[indexPath.row]
        
        cell?.configure(with: value)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       //return 145
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let thirdVC = GetRequestFullInfo()
        thirdVC.item = data[indexPath.row]
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
