<table class="table">
    <thead>
        <tr class="column-headers ">
            <th>{l s='Product' mod='wishlist_pres'}</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
            <th>{l s='Reference' mod='wishlist_pres'}</th>
            <th>{l s='Combination' mod='wishlist_pres'}</th>
            <th>{l s='Category' mod='wishlist_pres'}</th>
            <th class="text-center">{l s='Price (tax excl.)' mod='wishlist_pres'}</th>
            <th class="text-center">{l s='Available Qty' mod='wishlist_pres'}</th>
            <th class="text-center">{l s='Conversion rate' mod='wishlist_pres'}</th>
        </tr>
    </thead>
    <tbody>
        {if $products}
            {foreach from=$products item='product'}
                <tr>
                    <td class="position-type column-position">
                         <div class="text-center"> {$product.id_product|intval} </div>   
                    </td>
                    <td class="image-type column-image">
                        <img src="{$product.image_small_url|escape:'html':'UTF-8'}" />
                    </td>
                    <td class="link-type column-name">
                        <a target="_blank" class="text-primary" href="{$product.link|escape:'html':'UTF-8'}">
                            {$product.name|escape:'html':'UTF-8'}
                        </a>
                    </td>
                    <td class="data-type column-reference">{$product.reference|escape:'html':'UTF-8'} </td>
                    <td class="data-type column-combination">{if $product.combination}{$product.combination|escape:'html':'UTF-8'}{else}--{/if} </td>
                    <td class="data-type column-category_name">{$product.category_name|escape:'html':'UTF-8'} </td>
                    <td class="data-type column-price text-center">{$product.price|escape:'html':'UTF-8'} </td>
                    <td class="data-type column-quantity text-center"> {$product.quantity|intval} </td>
                    <td class="data-type column-conversionRate text-center">{$product.conversionRate|escape:'html':'UTF-8'} </td>
                </tr>
            {/foreach}
        {else} 
            <tr>
                <td class="no-data" colspan="9">{l s='No products found' mod='wishlist_pres'}</td>
            </tr>
        {/if}
    </tbody>
</table>