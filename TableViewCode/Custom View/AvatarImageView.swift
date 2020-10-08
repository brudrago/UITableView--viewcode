//
//  AvatarImageView.swift
//  TableViewCode
//
//  Created by Bruna Fernanda Drago on 08/10/20.
//

import UIKit

class AvatarImageView : UIImageView {
    
    let placeholderImage = UIImage(named: "avatar")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        
    }
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString)else { return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {return}
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else { return}
            guard let data = data else { return}
            
            guard let image = UIImage(data:data)else { return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
        
    }
}