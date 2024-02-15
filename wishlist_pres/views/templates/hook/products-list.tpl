<div class="wishlist-products-container-header">
    <h1>
        {$wishlistName|escape:'html':'UTF-8'}
        <span class="wishlist-products-count"> ({$totalRecords|intval}) </span>
       
        <div class="clearfix"></div>
    </h1>
    <div class="sort-by-row">
        <span class="col-sm-3 col-md-3 hidden-sm-down sort-by">Sort by:</span>
        <div class="col-sm-9 col-xs-8 col-md-9 products-sort-order dropdown">
            <button class="btn-unstyle select-title" rel="nofollow" data-toggle="dropdown" aria-label="Sort by selection" aria-haspopup="true" aria-expanded="false">
                {if $sortOrder=='product.name.asc'}
                    {l s='Name, A to Z' mod='wishlist_pres'}
                {elseif $sortOrder=='product.name.desc'}
                    {l s='Name, Z to A' mod='wishlist_pres'}
                {elseif $sortOrder=='product.price.asc'}
                    {l s='Price, low to high' mod='wishlist_pres'}
                {elseif $sortOrder=='wishlist_product.id_wishlist_product.desc'}
                    {l s='Last added' mod='wishlist_pres'}
                {else}
                    {l s='Relevance' mod='wishlist_pres'}
                {/if}
                <i class="material-icons float-xs-right"><i class="material-icons float-xs-right">arrow_drop_down</i></i>
            </button>
            <div class="dropdown-menu">
                <a href="{$urlView|escape:'html':'UTF-8'}" class="select-list" rel="nofollow">
                    {l s='Relevance' mod='wishlist_pres'}
                </a>
                <a href="{$urlView|escape:'html':'UTF-8'}&order=product.name.asc" class="select-list" rel="nofollow"> 
                {l s='Name, A to Z' mod='wishlist_pres'}
                </a>
                <a href="{$urlView|escape:'html':'UTF-8'}&order=product.name.desc" class="select-list" rel="nofollow">
                 {l s='Name, Z to A' mod='wishlist_pres'}
                 </a>
                <a href="{$urlView|escape:'html':'UTF-8'}&order=product.price.asc" class="select-list" rel="nofollow">
                 {l s='Price, low to high' mod='wishlist_pres'}
                </a>
                <a href="{$urlView|escape:'html':'UTF-8'}&order=wishlist_product.id_wishlist_product.desc" class="select-list" rel="nofollow">
                 {l s='Last added' mod='wishlist_pres'}
                </a>
            </div>
        </div>
    </div>
</div>
<section id="content" class="page-content card card-block">
    {if $products}
        <ul class="wishlist-products-list">
            {foreach from=$products item='product'}
                <li class="wishlist-products-item" data-id="{$product.id_product|intval}-{$product.id_product_attribute|intval}">
                    <div class="wishlist-product">
                        <a href="{$product.url|escape:'html':'UTF-8'}" class="wishlist-product-link">
                            <div class="wishlist-product-image">
                                {if $product.cover}
                                    <img src="{$product.cover.bySize.home_default.url|escape:'html':'UTF-8'}" alt="{if !empty($product.cover.legend)}{$product.cover.legend|escape:'html':'UTF-8'}{else}{$product.name|truncate:30:'...'|escape:'html':'UTF-8'}{/if}" title="{$product.name|escape:'html':'UTF-8'}" class="" />
                                {else}
                                    <img src="{$urls.no_picture_image.bySize.home_default.url|escape:'html':'UTF-8'}"loading="lazy"width="250" height="250"/>
                                {/if} 
                                <p class="wishlist-product-availability">
                                </p>
                            </div>
                            <div class="wishlist-product-right">
                                <p class="wishlist-product-title">{$product.name|escape:'html':'UTF-8'}</p>
                                <p class="wishlist-product-price">{$product.price|escape:'html':'UTF-8'}</p>
                                {if isset($product.attributes) && $product.attributes}
                                    <div class="wishlist-product-combinations">
                                        <p class="wishlist-product-combinations-text">
                                            {foreach from=$product.attributes item='attribute'}
                                                {$attribute.group|escape:'html':'UTF-8'}: {$attribute.name|escape:'html':'UTF-8'}
                                                <span>-</span>
                                            {/foreach}
                                            <span>
                                                {l s='Quantity' mod='wishlist_pres'} : 1
                                            </span> 
                                        </p> 
                                        <a href="{$product.url|escape:'html':'UTF-8'}">
                                            <i class="material-icons">create</i>
                                        </a>
                                    </div>
                                {/if}
                            </div>
                        </a>
                        <div class="wishlist-product-bottom " >
                            <button class="btn wishlist-product-addtocart btn-primary" data-id_wishlist="{$id_wishlist|intval}" data-link="{$link->getPageLink('cart',null,null,['add'=>1,'id_product'=>$product.id_product,'id_product_attribute'=>$product.id_product_attribute,'op'=>'up'])|escape:'html':'UTF-8'}" class="btn btn-primary add-to-cart-gift-product" data-id_product="{$product.id_product|intval}" data-id_product_attribute="{$product.id_product_attribute|intval}">
                                <i class="material-icons shopping-cart">
                                    shopping_cart
                                </i>
                                {l s='Add to cart' mod='wishlist_pres'}
                            </button>
                            {if !$isGuest}
                                <button class="wishlist-button-add btn_delete_wishlist view_page" data-url="{$deleteProductUrl nofilter}" data-id-product="{$product.id_product|intval}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id_wishlist="{$id_wishlist|intval}">
                                    <i class="material-icons">delete</i>
                                </button>
                            {/if}
                        </div>
                        <p class="wishlist-product-availability wishlist-product-availability-responsive">
                         <!----> <!----> 
                        </p>
                    </div>
                </li>
            {/foreach}
        </ul>
    {else}
        <div class="alert alert-warning">{l s='No products found' mod='wishlist_pres'}</div>
    {/if}
    {$paggination nofilter}
</section>