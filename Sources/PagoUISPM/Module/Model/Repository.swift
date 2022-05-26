//
//  RepositoryT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 06/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

public protocol Repository {
    
    func getData(predicate: Predicate) -> Model?
    func getData() -> Model?
    func getData(predicate: Predicate, completion: @escaping (Model)->())
    func getData(completion: @escaping (Model)->())
}

public extension Repository {
    
    func getData(predicate: Predicate) -> Model? { return nil }
    func getData() -> Model? { return nil }
    func getData(predicate: Predicate, completion: @escaping (Model)->()) { }
    func getData(completion: @escaping (Model)->()) { }
}

public protocol Predicate {}

public protocol Service {}
