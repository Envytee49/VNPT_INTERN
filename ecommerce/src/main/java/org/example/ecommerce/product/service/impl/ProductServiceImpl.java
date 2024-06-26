package org.example.ecommerce.product.service.impl;

import lombok.RequiredArgsConstructor;
import org.example.ecommerce.brand.exception.BrandNotFoundException;
import org.example.ecommerce.product.dto.request.ProductCreateRequest;
import org.example.ecommerce.product.dto.request.ProductUpdateRequest;
import org.example.ecommerce.product.dto.response.ProductDetailResponse;
import org.example.ecommerce.product.dto.response.ProductResponse;
import org.example.ecommerce.product.dto.response.ProductsResponse;
import org.example.ecommerce.product.exception.ProductNotFoundException;
import org.example.ecommerce.product.model.Product;
import org.example.ecommerce.product.repository.ProductRepository;
import org.example.ecommerce.product.service.AttributeService;
import org.example.ecommerce.product.service.ProductService;
import org.example.ecommerce.brand.model.Brand;
import org.example.ecommerce.brand.repository.BrandRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;
    private final BrandRepository brandRepository;
    private final AttributeService attributeService;
    @Override
    public Product addProduct(ProductCreateRequest productCreateRequest) {
        Brand brand = brandRepository.findById(productCreateRequest.getUuidBrand()).orElse(null);
        if(brand == null) {
            throw new BrandNotFoundException("Brand not found");
        }

        Product product = Product.builder()
                .publishedDate(productCreateRequest.getPublishedDate())
                .price(productCreateRequest.getPrice())
                .title(productCreateRequest.getTitle())
                .description(productCreateRequest.getDescription())
                .metaTitle(productCreateRequest.getMetaTitle())
                .quantity(productCreateRequest.getQuantity())
                .summary(productCreateRequest.getSummary())
                .type(productCreateRequest.getType())
                .uuidBrand(productCreateRequest.getUuidBrand())
                .build();
        return productRepository.save(product);
    }

    @Override
    public Product updateProduct(ProductUpdateRequest productUpdateRequest, String uuidProduct) {
        Product product = productRepository.findById(uuidProduct)
                .orElseThrow(() -> new ProductNotFoundException("product not found"));
        if(productUpdateRequest.getPrice() != null)
            product.setPrice(productUpdateRequest.getPrice());

        if(productUpdateRequest.getQuantity() != null)
            product.setQuantity(productUpdateRequest.getQuantity());

        if(productUpdateRequest.getPublishedDate() != null)
            product.setPublishedDate(productUpdateRequest.getPublishedDate());

        return productRepository.save(product);
    }

    @Override
    public void deleteProduct(String uuidProduct) {
        productRepository.deleteById(uuidProduct);
    }

    @Override
    public ProductsResponse getAllProducts(int page, int size) {

        // get all products
        List<Product> products = productRepository.findAll();

        // get all products by page and size
        Pageable pageRequest = PageRequest.of(page, size);
        Page<Product> productsByPageSize = productRepository.findAll(pageRequest);
        System.out.println(productsByPageSize.getSize());
        // convert to product response
        List<ProductResponse> productResponse = productsByPageSize
                .stream()
                .map(ProductResponse::from).toList();

        ProductsResponse productsResponse = new ProductsResponse();
        productsResponse.setTotal(products.size());
        productsResponse.setProducts(productResponse);

        return productsResponse;
    }

    @Override
    public ProductDetailResponse getProductByUuid(String uuidProduct) {
        Product product = productRepository
                .findById(uuidProduct)
                .orElseThrow(() -> new ProductNotFoundException("product not found"));

        Brand brand = brandRepository.findById(product.getUuidBrand())
                .orElseThrow(() -> new BrandNotFoundException("brand not found"));

        Map<String, String> attributes = attributeService.getAttributes(uuidProduct);
        return ProductDetailResponse.from(product, brand.getName(), attributes);
    }
}
