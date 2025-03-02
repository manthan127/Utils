//
//  File.swift
//  
//
//  Created by Home on 13/07/24.
//

import UIKit

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
    
    func registerNibs(_ cellIDs: UITableViewCell.Type... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            let id = String(describing: cellID.self)
            self.register(UINib(nibName: id, bundle: bundle), forCellReuseIdentifier: id)
        }
    }
}

extension UICollectionView {
    func dequeueCell<C: UICollectionViewCell>(ofType type: C.Type, withIdentifier id: String? = nil, indexPath: IndexPath) -> C? {
        let id = id ?? String(describing: type.self)
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? C
    }
    
    func dequeueBaseCell(withIdentifier id: String? = nil, indexPath: IndexPath)-> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: id ?? "BaseCellClass_id", for: indexPath)
    }
    
    func registerBaseCellClass(withIdentifier id: String? = nil) {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: id ?? "BaseCellClass_id")
    }
    
    func registerNibs(_ cellIDs: String... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            self.register(UINib(nibName: cellID, bundle: bundle), forCellWithReuseIdentifier: cellID)
        }
    }
    
    func registerNibs(_ cellIDs: UICollectionViewCell.Type... , bundle: Bundle? = nil) {
        for cellID in cellIDs {
            let id = String(describing: cellID.self)
            self.register(UINib(nibName: id, bundle: bundle), forCellWithReuseIdentifier: id)
        }
    }
}

class C1: UITableViewCell {
    
}

class C2: UITableViewCell {
    
}
