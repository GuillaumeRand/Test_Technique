<div class="list-order-products">
    {foreach from = $products item='product'}
        <a target="_blank" href="{$link->getProductLink($product.id_product,null,null,null,null,null,$product.id_product_attribute)|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'} ">
        {if $product.image}
            <img src="{$product.image|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" />
        {else}
            {$product.name|escape:'html':'UTF-8'}
        {/if}
        </a>
    {/foreach}
</div>