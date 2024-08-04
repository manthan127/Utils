//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import UIKit

public
extension UITableView {
    func dequeueCell<C: UITableViewCell>(ofType type: C.Type, withIdentifier id: String? = nil) -> C? {
        let id = id ?? String(describing: type.self)
        return dequeueReusableCell(withIdentifier: id) as? C
    }
    
    func dequeueCell<C: UITableViewCell>(ofType type: C.Type, withIdentifier id: String? = nil, indexPath: IndexPath) -> C? {
        let id = id ?? String(describing: type.self)
        return dequeueReusableCell(withIdentifier: id, for: indexPath) as? C
    }
    
    func registerNibs(_ cellIDs: String... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            self.register(UINib(nibName: cellID, bundle: bundle), forCellReuseIdentifier: cellID)
        }
    }
}

public
extension UICollectionView {
    func dequeueCell<C: UICollectionViewCell>(ofType type: C.Type, withIdentifier id: String? = nil, indexPath: IndexPath) -> C? {
        let id = id ?? String(describing: type.self)
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? C
    }
    
    func registerNibs(_ cellIDs: String... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            self.register(UINib(nibName: cellID, bundle: bundle), forCellWithReuseIdentifier: cellID)
        }
    }
}
