//  PostRequestPage.swift
//  UsingGetPostmethods
//
//  Created by Nurlan Seitov on 2/4/23.
//

import UIKit
import SnapKit

class PostRequestPage: UIViewController {
    
    private lazy var textField1: UITextField = {
        let text = UITextField()
        text.backgroundColor = .lightGray
        text.placeholder = "Input ID"
        text.layer.cornerRadius = 10
        return text
    } ()
    
    private lazy var textField2: UITextField = {
        let text = UITextField()
        text.backgroundColor = .lightGray
        text.placeholder = "Input Product Title"
        text.layer.cornerRadius = 10
        return text
    } ()
    
    private lazy var postRequest: UIButton = {
        let post = UIButton(type: .system)
        post.setTitle("POST", for: .normal)
        post.backgroundColor = .systemRed
        post.setTitleColor(.white, for: .normal)
        post.layer.cornerRadius = 10
        post.addTarget(self, action: #selector(postRequest(sender:)), for: .touchUpInside)
        return post
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstrainPost()
    }
    
    
    /*
     // MARK: - Navigation
     */
    private func setupConstrainPost() {
        view.addSubview(textField1)
        textField1.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        
        view.addSubview(textField2)
        textField2.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        
        view.addSubview(postRequest)
        postRequest.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    private func checktext(_ name: UITextField) -> Bool {
        var b: Bool = false
        if name.text?.isEmpty ?? true {
            b = true
            name.layer.borderWidth = 2
            name.layer.borderColor = UIColor.red.cgColor
            name.placeholder = "Please fill in the information"
        }
        return b
    }
    
    @objc private func postRequest(sender: UIButton) {
        let number: Int = 0
         checktext(textField1?.text)
         checktext(textField2?.text)
       
            if number != Int(textField1.text!) {
                textField1.text = ""
                textField1.layer.borderWidth = 2
                textField1.layer.borderColor = UIColor.red.cgColor
                textField1.placeholder = "Not a valid number"
            }
        
        else
        {
            ApiManager.shared.postRequest(id: Int(textField1.text!)!, title: textField2.text!) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        
                        self.showAlert(with: "Success", message: "With status code: \(data)")
                    }
                case .failure(let error):
                    self.showAlert(with: "Error", message: "With status code: \(error)")
                    break
                }
            }
        }
    }
private func showAlert(with title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(.init(title: "Ok", style: .default))
    present(alert, animated: true)
    }
}

