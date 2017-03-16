//
//  CategoriesList.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/18/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class CategoriesList {
    
    var arrayCategories: [Categories] = []
    
    let c1 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Aeroporto")
    let c2 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Água e Esgoto")
    let c3 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Estabelecimento irregular")
    let c4 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Iluminação e Energia")
    let c5 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Limpeza e Conservação")
    let c6 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Meio Ambiente")
    let c7 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Pedestre e Ciclistas")
    let c8 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Saúde")
    let c9 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Segurança")
    let c10 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Transporte Público")
    let c11 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Urbanismo")
    let c12 = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: "Vias e Trânsito")
    
    init () {        
        
    }
    
    func categoriesTest () {
        self.arrayCategories.append(c1)
        self.arrayCategories.append(c2)
        self.arrayCategories.append(c3)
        self.arrayCategories.append(c4)
        self.arrayCategories.append(c5)
        self.arrayCategories.append(c6)
        self.arrayCategories.append(c7)
        self.arrayCategories.append(c8)
        self.arrayCategories.append(c9)
        self.arrayCategories.append(c10)
        self.arrayCategories.append(c11)
        self.arrayCategories.append(c12)
    }
    
    func setCategories (titleCategory: String) {
        let category = Categories(imgCategory: "paisagem_urbana.jpg", titleCategory: titleCategory)
        self.arrayCategories.append(category)
    }
    
    func getArrayCategories () -> [Categories] {
        return arrayCategories
    }
    
}