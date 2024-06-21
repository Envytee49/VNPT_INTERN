package org.example.ecommerce.product.service;

import org.example.ecommerce.product.dto.request.ProductCreateRequest;
import org.example.ecommerce.product.dto.response.ProductDetailResponse;
import org.example.ecommerce.product.model.Product;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface ProductService {
    Product addProduct(ProductCreateRequest productCreateRequest);
    Product updateProduct(ProductCreateRequest productCreateRequest);
    void deleteProduct(String uuidProduct);
    List<ProductDetailResponse> getAllProducts();
    ProductDetailResponse getProductByUuid(String uuidProduct);
}