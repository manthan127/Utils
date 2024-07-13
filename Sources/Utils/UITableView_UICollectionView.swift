//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import UIKit

extension UITableView {
    func dequeueCell<C: UITableViewCell>(ofType type: C.Type) -> C? {
        dequeueReusableCell(withIdentifier: String(describing: type.self)) as? C
    }
    
    func dequeueCell<C: UITableViewCell>(ofType type: C.Type, indexPath: IndexPath) -> C? {
        dequeueReusableCell(withIdentifier: String(describing: type.self), for: indexPath) as? C
    }
    
    func registerNibs(_ cellIDs: String... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            self.register(UINib(nibName: cellID, bundle: bundle), forCellReuseIdentifier: cellID)
        }
    }
}

extension UICollectionView {
    func dequeueCell<C: UICollectionViewCell>(ofType type: C.Type, indexPath: IndexPath) -> C? {
        dequeueReusableCell(withReuseIdentifier: String(describing: type.self), for: indexPath) as? C
    }
    
    func registerNibs(_ cellIDs: String... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            self.register(UINib(nibName: cellID, bundle: bundle), forCellWithReuseIdentifier: cellID)
        }
    }
}
