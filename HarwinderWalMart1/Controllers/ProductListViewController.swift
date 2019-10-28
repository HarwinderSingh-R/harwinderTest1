//
//  ViewController.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductListViewController: AbstractViewController {
   
    @IBOutlet weak var tblVw_ProductList: UITableView!
    private var productsList: ProductList!
    private lazy var productItemList:[Products] = []
    private let refreshControl = UIRefreshControl()
    private var pageNum:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_title.text = "Product List"
        self.setFeatureToControls()
        // Do any additional setup after loading the view.
    }
    
    func setFeatureToControls(){
        self.tblVw_ProductList.tableFooterView = UIView()
        if #available(iOS 10.0, *) {
            self.tblVw_ProductList.refreshControl = refreshControl
        } else {
            self.tblVw_ProductList.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(renderProductData(_:)), for: .valueChanged)
        self.fetchProductList(_pageNum: self.pageNum, _pageSize: kPRODUCTSIZE)
    }
    
    func redirectToProductDetail(_itemIndex: Int){
        let controller = self.storyboard?.instantiateViewController(identifier: kPRODUCTDETAILVIEWCONTROLLERIDENTIFIER) as! ProductDetailViewController
        controller.productList = self.productItemList
        controller.itemIndex = _itemIndex
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func fetchProductList(_pageNum:Int, _pageSize:Int){
        let productFacade = ProductListFacade()
        let urlParam:String = String(_pageNum) + "/" + String(_pageSize)
        productFacade.fetchProductList(_url: urlParam) { (_productList, error) in
            if(error == nil &&  _productList?.statusCode == 200){
                self.productsList = _productList
                self.productsList.products!.append(contentsOf: self.productItemList)
                self.productItemList = self.productsList.products!
                self.tblVw_ProductList.reloadData()
            }
            else if(error == nil &&  _productList?.statusCode != 200){
                SceneDelegate.shared?.showBanner(bannerTitle:_productList!.error! + " " + _productList!.message!)
            }
        }
    }
    
    @objc private func renderProductData(_ sender: Any) {
            self.pageNum = (NetworkManager.sharedInstance.isNetworkAvailable) ? self.pageNum + 1 : self.pageNum
           self.fetchProductList(_pageNum: self.pageNum, _pageSize: kPRODUCTSIZE)
           self.refreshControl.endRefreshing()
       }
    
    override func onconnectingNetwork(){
        self.network.reachability.whenReachable = { reachability in
                if((SceneDelegate.shared?.banner_VW.isHidden)!){
                        SceneDelegate.shared?.showBanner(bannerTitle: kNETWORK_AVAILABLE)
                    if(self.productItemList.count == 0){
                        self.fetchProductList(_pageNum: self.pageNum, _pageSize: kPRODUCTSIZE)}
                    }
            }
        }
}
extension ProductListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblVw_ProductList.dequeueReusableCell(withIdentifier: kPRODUCTTABLECELLIDENTIFIER, for: indexPath) as! ProductTableViewCell
        let productItem: Products = self.productItemList[indexPath.row]
        cell.setTableCellUI(product: productItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return   UITableView.automaticDimension
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.redirectToProductDetail(_itemIndex: indexPath.row)
    }
    
}

