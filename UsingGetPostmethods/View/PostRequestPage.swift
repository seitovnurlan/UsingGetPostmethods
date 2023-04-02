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
        text.backgroundColor = .systemGray6
        text.placeholder = " Input ID"
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray.cgColor
        text.addTarget(self, action: #selector(textFieldAction(_ :)), for: .editingChanged)
        return text
    } ()
    
    private lazy var textField2: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemGray6
        text.placeholder = " Input Product Title"
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray.cgColor
        text.addTarget(self, action: #selector(textFieldAction(_ :)), for: .editingChanged)
        return text
    } ()
    
    private lazy var postRequest: UIButton = {
        let post = UIButton(type: .system)
        post.setTitle("POST", for: .normal)
        post.backgroundColor = .lightGray
        post.isEnabled = false
        post.setTitleColor(.white, for: .normal)
        post.layer.cornerRadius = 10
        post.layer.borderWidth = 1
        post.layer.borderColor = UIColor.gray.cgColor
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
            make.top.equalTo(view.snp.top).offset(300)
            make.centerX.equalToSuperview()
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
    private func checktext(_ textField: UITextField) {
       
        guard let text = textField.text else { return }
        if text.isEmpty {
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            textField.placeholder = "Please fill in the information"
        } else {
            textField.layer.borderWidth = 0
        }
    }
    
    @objc private func textFieldAction(_ sender: Any) {

        if textField1.hasText && textField2.hasText {
            postRequest.backgroundColor = .systemRed
            postRequest.isEnabled = true }
        }
    
    
    @objc private func postRequest(sender: UIButton) {
    
//         checktext(textField1?.text)
//         checktext(textField2?.text)
       
        if (Int(textField1.text!) == nil) || (textField1.text?.isEmpty ?? true) || (textField2.text?.isEmpty ?? true)
        {
            print(textField1.text!)
            textField1.text = ""
            textField1.layer.borderWidth = 2
            textField1.layer.borderColor = UIColor.red.cgColor
            textField1.placeholder = "Not a valid number or empty"
            
            textField2.layer.borderWidth = 2
            textField2.layer.borderColor = UIColor.red.cgColor
            textField2.placeholder = "Not a valid number or empty"
            
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

