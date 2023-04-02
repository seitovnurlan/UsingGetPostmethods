//  ViewController.swift
//  UsingGetPostmethods
//
//  Created by Nurlan Seitov on 2/4/23.
//
import UIKit
import SnapKit
import Kingfisher


class ViewController: UIViewController {
    
    private lazy var imagePage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.image = UIImage(named: "methods2")
        return image
    } ()
    
    private lazy var getRequest: UIButton = {
        let get = UIButton(type: .system)
        get.setTitle("GET", for: .normal)
//        get.layer
        get.backgroundColor = .systemBlue
        get.setTitleColor(.white, for: .normal)
        get.layer.cornerRadius = 10
        get.addTarget(self, action: #selector(getRequest(sender:)), for: .touchUpInside)
        return get
    } ()
    
    private lazy var putRequest: UIButton = {
        let put = UIButton(type: .system)
        put.setTitle("PUT", for: .normal)
        put.backgroundColor = .systemGreen
        put.setTitleColor(.white, for: .normal)
        put.layer.cornerRadius = 10
        put.addTarget(self, action: #selector(getRequest(sender:)), for: .touchUpInside)
        return put
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
        setupConstraints()
       
    }
    func setupConstraints() {
        view.backgroundColor = .systemGray5
        
        view.addSubview(imagePage)
        imagePage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(180)
        }
        
        view.addSubview(getRequest)
        getRequest.snp.makeConstraints { make in
            make.top.equalTo(imagePage.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        
        view.addSubview(putRequest)
        putRequest.snp.makeConstraints { make in
            make.top.equalTo(getRequest.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        view.addSubview(postRequest)
        postRequest.snp.makeConstraints { make in
            make.top.equalTo(putRequest.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
    
    @objc private func getRequest(sender: UIButton) {
        ApiManager.shared.getRequest { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let vc = GetRequestPage()
                    vc.data = data.products ?? []
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    @objc private func postRequest(sender: UIButton) {
        navigationController?.pushViewController(PostRequestPage(), animated: true)
    }

}

