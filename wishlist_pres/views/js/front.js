/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License version 3.0
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License version 3.0
 */

$(document).ready(function(){
    if($('.product-description > .wishlist-button-add').length)
    {
        $('.product-description >.wishlist-button-add').each(function(){
            $(this).parent().before($(this).clone());
            $(this).remove();
        });
    }
    $(document).on('click','.wishlist-button-add.add_wishlist',function(e){
        e.preventDefault();
        $('.wishlist-add-to .wishlist-modal').removeClass('fade').addClass('show');
        $('#wl_id_product_current').val($(this).data('id-product'));
        $('#wl_id_product_attribute_current').val($(this).data('id-product-attribute'));
    });
    $(document).on('click','button[data-dismiss="modal"]',function(){
       $(this).parents('.wishlist-modal').addClass('fade').removeClass('show'); 
       $('.quickview').removeClass('hidden');
    });
    $(document).on('click','.wishlist-add-to-new',function(){
        $('.wishlist-create .wishlist-modal').removeClass('fade').addClass('show');
        $('.quickview').addClass('hidden');
        $('.wishlist-add-to .wishlist-modal').addClass('fade').removeClass('show');
        $('#wishlist_name').val('')
        
    });
    $(document).on('click','#wishlist_name',function(){
        setTimeout(function(){$('#wishlist_name').focus()},300);
    })
    $(document).on('click','.wishlist-button-add.login',function(){
        $('.wishlist-login .wishlist-modal').removeClass('fade').addClass('show');
    });
    $(document).on('click','.btn-submit-new-wishlist',function(){
        wishlist.addNewWishlist();
    });
    $(document).on('click','.wishlist-chooselist .item-wishlist',function(){
       wishlist.addProductToWishlist($(this).data('id'),$('#wl_id_product_current').val(),$('#wl_id_product_attribute_current').val()); 
    });
    $(document).on('click','.wishlist-button-add.delete_wishlist,.btn_delete_wishlist',function(e){
        e.preventDefault();
        wishlist.deleteProductFromWishlist($(this));
    });
    $(document).on("click",'.wishlist-list-item-actions',function(){
        $(this).next().next('.dropdown-menu').toggleClass('show');
    });
    $(document).mouseup(function (e)
    {
        if($('.buttons-share-wishlist.show').length)
        {
            var container_dropdown = $('.buttons-share-wishlist.show');
            if (!container_dropdown.is(e.target)&& container_dropdown.has(e.target).length === 0)
            {
                container_dropdown.removeClass('show');
            }
        }
    }); 
    $(document).on('click','.btn-copy-url-share',function(e){
        e.preventDefault();
        $(this).next('input').select();
        document.execCommand("copy");
        $('.wishlist-toast .wishlist-toast-text').html($('.wishlist-share').data('copied-text'));
        $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
        setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);
        $('.buttons-share-wishlist').removeClass('show')
    });
    $(document).on('click','.wishlist-btn-delete',function(){
        wishlist.deleteWishlist($(this).data('url-delete'));
    });
    $(document).on('click','.wishlist-product-addtocart',function(){
        wishlist.addToCart($(this)); 
    });
    $(document ).ajaxComplete(function( event, xhr, settings ) {
        if($('.product-add-to-cart .wishlist-button-add').length &&  xhr.responseText && xhr.responseText.indexOf("product_add_to_cart")>=0)
        {
            var data = JSON.parse(xhr.responseText);
            if(data.product_add_to_cart)
            {
                $('.product-actions .product-add-to-cart').replaceWith(data.product_add_to_cart);
            }
        }
    });
});
wishlist = {
    addNewWishlist : function (){
        var wishlist_name = $('#wishlist_name').val();
        if(!wishlist_name)
        {
            $('.wishlist-toast .wishlist-toast-text').html($('.wishlist-toast').data('required'));
            $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
            setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);
        }
        else
        {
            var ajax_url = $('.wishlist-create').data('url');
            $.ajax({
                url: ajax_url,
                data: 'wishlist_name='+wishlist_name,
                type: 'post',
                dataType: 'json',
                success: function(json){
                    $('.wishlist-toast .wishlist-toast-text').html(json.message);
                    if(json.success)
                    {
                        $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
                        $('.wishlist-create .wishlist-modal').removeClass('show').addClass('fade');
                        $('.quickview').removeClass('hidden');
                        if($('#module-wishlist_pres-lists').length)
                        {
                            var li_item ='<tr class="wishlist-list-item" data-id="'+json.datas.id_wishlist+'" data-name="'+json.datas.name+'">';
                            li_item +='<td><a class="wishlist-list-item-link" href="'+json.datas.listUrl+'">';
                            li_item +='<p class="wishlist-list-item-title"><span class="wishlist_name">'+json.datas.name+'</span></p>';
                            li_item += '</a></td>';
                            li_item +='<td>--</td>';
                            li_item +='<td class="wishlist-list-item-right">';
                                            li_item +='<input name="share_link_wishlist" type="text" value="'+json.datas.shareUrl+'" style="opacity:0;width:1px"  />';
                                        li_item +='</li>';
                                    li_item +='</ul>';
                                li_item +='</div>';
                                li_item +='<button title="'+Delete_text+'" class="wishlist-btn-delete" data-url-delete="'+json.datas.deleteUrl+'">';
                                    li_item +='<i><svg style="width:14px; height:14px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M135.2 17.69C140.6 6.848 151.7 0 163.8 0H284.2C296.3 0 307.4 6.848 312.8 17.69L320 32H416C433.7 32 448 46.33 448 64C448 81.67 433.7 96 416 96H32C14.33 96 0 81.67 0 64C0 46.33 14.33 32 32 32H128L135.2 17.69zM394.8 466.1C393.2 492.3 372.3 512 346.9 512H101.1C75.75 512 54.77 492.3 53.19 466.1L31.1 128H416L394.8 466.1z"/></svg></i>';
                                li_item +='</button>';
                            li_item += '</td>';   
                            li_item +='</tr>';
                            $('.wishlist-container .wishlist-list').append(li_item);
                        }
                        else
                        {
                            $('.wishlist-add-to .wishlist-modal').addClass('show').removeClass('fade');
                            $('.wishlist-chooselist .wishlist-list').append('<li class="item-wishlist" data-id="'+json.datas.id_wishlist+'"><p>'+json.datas.name+'</p></li>');
                        }
                        
                    }
                    else
                    {
                        $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
                    }
                    setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);    
                },
                error: function(xhr, status, error)
                {     
                    
                }
            });
        } 
    },
    addProductToWishlist: function(idWishlist,idProduct,idProductAttribute){
        var ajax_url = $('.wishlist-add-to').data('url');
        $.ajax({
            url: ajax_url,
            data: {
                id_wishlist: idWishlist,
                id_product : idProduct,
                id_product_attribute : idProductAttribute,
            },
            type: 'post',
            dataType: 'json',
            success: function(json){
                $('.wishlist-toast .wishlist-toast-text').html(json.message);
                if(json.success)
                {
                    $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
                    $('.wishlist-button-add_'+idProduct+'_'+idProductAttribute+'').addClass('delete_wishlist').removeClass('add_wishlist');
                    $('.wishlist-button-add_'+idProduct+'_'+idProductAttribute+'').attr('data-id_wishlist',idWishlist);
                    $('.wishlist-add-to .wishlist-modal').removeClass('show').addClass('fade');
                }
                else
                {
                    $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
                }
                setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);    
            },
            error: function(xhr, status, error)
            {     
                
            }
        });
    },
    deleteProductFromWishlist:function($button)
    {
        if(!$button.hasClass('view_page') || confirm(confirm_delete_product_text))
        {
            var ajax_url = $button.data('url');
            var idProduct = parseInt($button.data('id-product'));
            var idProductAttribute = parseInt($button.data('id-product-attribute'));
            var idWishlist = parseInt($button.attr('data-id_wishlist'));
            if(!$button.hasClass('loading'))
            {
                $button.addClass('loading');
                $.ajax({
                    url: ajax_url,
                    data: {
                        action:'deleteProductFromWishlist',
                        id_product : idProduct,
                        id_product_attribute : idProductAttribute,
                        id_wishlist:idWishlist,
                        viewpage: $button.hasClass('view_page') ? true :false
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function(json){
                        $button.removeClass('loading');
                        $('.wishlist-toast .wishlist-toast-text').html(json.message);
                        if(json.success)
                        {
                            $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
                            if($button.hasClass('view_page'))
                            {
                                $('.wishlist-products-container').html(json.products_list);
                            }
                            else
                                $('.wishlist-button-add_'+idProduct+'_'+idProductAttribute+'').removeClass('delete_wishlist').addClass('add_wishlist');
                        }
                        else
                        {
                            $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
                        }
                        setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);    
                    },
                    error: function(xhr, status, error)
                    {     
                        
                    }
                });
            }
        }
    },
    renameWishlist :function(){
        var wishlist_name = $('#wishlist_name_edit').val();
        var idWishlist = $('#id_wishlist_edit').val();
        if(!wishlist_name)
        {
            $('.wishlist-toast .wishlist-toast-text').html($('.wishlist-toast').data('required'));
            $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
            setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);
        }
        else
        {
            var ajax_url = $('.wishlist-rename').data('url');
            $.ajax({
                url: ajax_url,
                data: 'wishlist_name='+wishlist_name+'&id_wishlist='+idWishlist,
                type: 'post',
                dataType: 'json',
                success: function(json){
                    $('.wishlist-toast .wishlist-toast-text').html(json.message);
                    if(json.success)
                    {
                        $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
                        $('.wishlist-rename .wishlist-modal').removeClass('show').addClass('fade');
                        $('.wishlist-list-item[data-id="'+json.datas.id_wishlist+'"] .wishlist_name').html(json.datas.name);
                        $('.wishlist-list-item[data-id="'+json.datas.id_wishlist+'"]').attr('data-name',json.datas.name);
                    }
                    else
                    {
                        $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
                    }
                    setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);    
                },
                error: function(xhr, status, error)
                {     
                    
                }
            });
        }
    },
    deleteWishlist : function(url_delete)
    {
        if(confirm(confirm_delete_wishlist_text))
        {
            $.ajax({
                url: url_delete,
                data: '',
                type: 'post',
                dataType: 'json',
                success: function(json){
                    $('.wishlist-toast .wishlist-toast-text').html(json.message);
                    if(json.success)
                    {
                        $('.wishlist-toast').removeClass('error').addClass('success').addClass('isActive');
                        $('.wishlist-list-item[data-id="'+json.datas.id_wishlist+'"]').remove();
                    }
                    else
                    {
                        $('.wishlist-toast').removeClass('success').addClass('error').addClass('isActive');
                    }
                    setTimeout(function(){$('.wishlist-toast').removeClass('isActive');},3000);    
                },
                error: function(xhr, status, error)
                {     
                    
                }
            });
        }
    },
    addToCart: function($button)
    {
        if(!$button.hasClass('loading'))
        {
            $button.addClass('loading');
            var url_link = $button.data('link');
            $.ajax({
                url: url_link,
                data: 'action=update&ajax=1',
                type: 'post',
                dataType: 'json',                
                success: function(json){ 
                    $button.removeClass('loading');
                    if(json.hasError && json.errors)
                    {
                        alert(json.errors[0]);
                    }
                    else
                    {
                        wishlist.addProductToCart(json.id_product,json.id_product_attribute,$button.data('id_wishlist'));
                        prestashop.emit("updateCart", {
                            reason: {
                                idProduct: json.id_product,
                                idProductAttribute: json.id_product_attribute,
                                idCustomization: 0,
                                linkAction: "add-to-cart",
                                cart: json.cart
                            },
                            resp: json
                        });
                    }
                    
                }
            });
        }
    },
    addProductToCart: function(idProduct,idProductAttribute,idWishlist){
        $.ajax({
            url: addProductToCartUrl,
            data: {
                id_product : idProduct,
                id_product_attribute : idProductAttribute,
                idWishlist : idWishlist
            },
            type: 'post',
            dataType: 'json',
            success: function(json){
                   
            },
            error: function(xhr, status, error)
            {     
                
            }
        });
    },
}