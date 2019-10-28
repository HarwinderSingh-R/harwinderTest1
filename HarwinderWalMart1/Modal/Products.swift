//
//  Products.swift
//
//  Created by mac on 24/10/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Products: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reviewCount = "reviewCount"
    static let productId = "productId"
    static let productName = "productName"
    static let longDescription = "longDescription"
    static let reviewRating = "reviewRating"
    static let inStock = "inStock"
    static let shortDescription = "shortDescription"
    static let productImage = "productImage"
    static let price = "price"
  }

  // MARK: Properties
  public var reviewCount: Int?
  public var productId: String?
  public var productName: String?
  public var longDescription: String?
  public var reviewRating: Int?
  public var inStock: Bool? = false
  public var shortDescription: String?
  public var productImage: String?
  public var price: String?

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
    reviewCount = json[SerializationKeys.reviewCount].int
    productId = json[SerializationKeys.productId].string
    productName = json[SerializationKeys.productName].string
    longDescription = json[SerializationKeys.longDescription].string
    reviewRating = json[SerializationKeys.reviewRating].int
    inStock = json[SerializationKeys.inStock].boolValue
    shortDescription = json[SerializationKeys.shortDescription].string
    productImage = json[SerializationKeys.productImage].string
    price = json[SerializationKeys.price].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reviewCount { dictionary[SerializationKeys.reviewCount] = value }
    if let value = productId { dictionary[SerializationKeys.productId] = value }
    if let value = productName { dictionary[SerializationKeys.productName] = value }
    if let value = longDescription { dictionary[SerializationKeys.longDescription] = value }
    if let value = reviewRating { dictionary[SerializationKeys.reviewRating] = value }
    dictionary[SerializationKeys.inStock] = inStock
    if let value = shortDescription { dictionary[SerializationKeys.shortDescription] = value }
    if let value = productImage { dictionary[SerializationKeys.productImage] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reviewCount = aDecoder.decodeObject(forKey: SerializationKeys.reviewCount) as? Int
    self.productId = aDecoder.decodeObject(forKey: SerializationKeys.productId) as? String
    self.productName = aDecoder.decodeObject(forKey: SerializationKeys.productName) as? String
    self.longDescription = aDecoder.decodeObject(forKey: SerializationKeys.longDescription) as? String
    self.reviewRating = aDecoder.decodeObject(forKey: SerializationKeys.reviewRating) as? Int
    self.inStock = aDecoder.decodeBool(forKey: SerializationKeys.inStock)
    self.shortDescription = aDecoder.decodeObject(forKey: SerializationKeys.shortDescription) as? String
    self.productImage = aDecoder.decodeObject(forKey: SerializationKeys.productImage) as? String
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reviewCount, forKey: SerializationKeys.reviewCount)
    aCoder.encode(productId, forKey: SerializationKeys.productId)
    aCoder.encode(productName, forKey: SerializationKeys.productName)
    aCoder.encode(longDescription, forKey: SerializationKeys.longDescription)
    aCoder.encode(reviewRating, forKey: SerializationKeys.reviewRating)
    aCoder.encode(inStock, forKey: SerializationKeys.inStock)
    aCoder.encode(shortDescription, forKey: SerializationKeys.shortDescription)
    aCoder.encode(productImage, forKey: SerializationKeys.productImage)
    aCoder.encode(price, forKey: SerializationKeys.price)
  }

}
