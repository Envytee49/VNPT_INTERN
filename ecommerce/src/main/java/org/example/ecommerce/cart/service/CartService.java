package org.example.ecommerce.cart.service;

import org.example.ecommerce.cart.dto.request.AddToCartRequest;
import org.example.ecommerce.cart.dto.request.UpdateCartRequest;
import org.example.ecommerce.cart.dto.response.CartItemResponse;
import org.example.ecommerce.common.dto.PageDtoIn;
import org.example.ecommerce.common.dto.PageDtoOut;

public interface CartService {
    PageDtoOut<CartItemResponse> getCart(PageDtoIn pageDtoIn);
    void add(AddToCartRequest modifyCartRequest);
    void delete(String uuidCartItem);
    void deleteAll();
    void update(UpdateCartRequest request);
}
