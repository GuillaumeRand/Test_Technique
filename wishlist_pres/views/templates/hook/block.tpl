
<section class="wishlist_products_list_section featured-products clearfix mt-3{if $blockName=='left' or $blockName=='right'} block left_right{/if}">
    <div class="wl-box-header">
        <h2 class="h2 products-section-title text-uppercase">
            {$block_title|escape:'html':'UTF-8'}
        </h2>
        {if count($wishlists) >1}
            <select name="select-wislist-products" data-page-name="{$controller|escape:'html':'UTF-8'}" data-position="{$blockName|escape:'html':'UTF-8'}" data-link-action="{$link->getModuleLink('wishlist_pres','action',['action'=>'getProductList']) nofilter}">
                {foreach from=$wishlists item='wishlist'}
                    <option value="{$wishlist.id_wishlist|intval}">{$wishlist.name|escape:'html':'UTF-8'}</option>
                {/foreach}
            </select>
        {/if}
    </div>
    <div class="wl-box-products">
        {$list_product nofilter}
    </div>
</section>
