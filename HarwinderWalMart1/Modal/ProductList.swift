//
//  ProductList.swift
//
//  Created by mac on 24/10/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pageSize = "pageSize"
    static let totalProducts = "totalProducts"
    static let pageNumber = "pageNumber"
    static let statusCode = "statusCode"
    static let products = "products"
    static let error = "error"
    static let message = "message"
  }

  // MARK: Properties
  public var pageSize: Int?
  public var totalProducts: Int?
  public var pageNumber: Int?
  public var statusCode: Int?
  public var products: [Products]?
  public var error: String?
  public var message: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    pageSize = json[SerializationKeys.pageSize].int
    totalProducts = json[SerializationKeys.totalProducts].int
    pageNumber = json[SerializationKeys.pageNumber].int
    statusCode = json[SerializationKeys.statusCode].int
    if let items = json[SerializationKeys.products].array { products = items.map { Products(json: $0) } }
    error = json[SerializationKeys.error].string
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pageSize { dictionary[SerializationKeys.pageSize] = value }
    if let value = totalProducts { dictionary[SerializationKeys.totalProducts] = value }
    if let value = pageNumber { dictionary[SerializationKeys.pageNumber] = value }
    if let value = statusCode { dictionary[SerializationKeys.statusCode] = value }
    if let value = products { dictionary[SerializationKeys.products] = value.map { $0.dictionaryRepresentation() } }
    if let value = error { dictionary[SerializationKeys.error] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pageSize = aDecoder.decodeObject(forKey: SerializationKeys.pageSize) as? Int
    self.totalProducts = aDecoder.decodeObject(forKey: SerializationKeys.totalProducts) as? Int
    self.pageNumber = aDecoder.decodeObject(forKey: SerializationKeys.pageNumber) as? Int
    self.statusCode = aDecoder.decodeObject(forKey: SerializationKeys.statusCode) as? Int
    self.products = aDecoder.decodeObject(forKey: SerializationKeys.products) as? [Products]
    self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pageSize, forKey: SerializationKeys.pageSize)
    aCoder.encode(totalProducts, forKey: SerializationKeys.totalProducts)
    aCoder.encode(pageNumber, forKey: SerializationKeys.pageNumber)
    aCoder.encode(statusCode, forKey: SerializationKeys.statusCode)
    aCoder.encode(products, forKey: SerializationKeys.products)
    aCoder.encode(statusCode, forKey: SerializationKeys.error)
    aCoder.encode(products, forKey: SerializationKeys.message)
  }

}
