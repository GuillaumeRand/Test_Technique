
{if $blockName=='home' || $blockName=='product' || $blockName=='shipping'}
    {assign let='nbItemsPerLine' value=3}
	{assign let='nbItemsPerLineTablet' value=4}
	{assign let='nbItemsPerLineMobile' value=6}
{else}
    {assign let='nbItemsPerLine' value=12}
	{assign let='nbItemsPerLineTablet' value=12}
	{assign let='nbItemsPerLineMobile' value=4}
{/if}
{if !isset($ajax) || !$ajax}
    <script type="text/javascript">
        {if $blockName=='home' || $blockName=='product' || $blockName=='shipping'}
            let wlp_nbItemsPerLine =4;
            let wlp_nbItemsPerLineTablet =3;
            let wlp_nbItemsPerLineMobile=2;
        {else}
            let wlp_nbItemsPerLine =1;
            let wlp_nbItemsPerLineTablet =1;
            let wlp_nbItemsPerLineMobile=1;
        {/if}
    </script>
{/if}
<div class="{$blockName|escape:'html':'UTF-8'} products product_list wishlist_products_list_wrapper layout-{$wlp_display_type|escape:'html':'UTF-8'} wlp_desktop_{$nbItemsPerLine|intval} wlp_tablet_{$nbItemsPerLineTablet|intval} wlp_mobile_{$nbItemsPerLineMobile|intval}{if $slide_auto_play} auto{/if} ">
    {foreach from=$products item="product"}
      {include file="catalog/_partials/miniatures/product.tpl" product=$product}
    {/foreach}
</div>
<a href="{$allWishlistProductsLink|escape:'html':'UTF-8'}" class="float-xs-left float-md-right wlp_all_products">{l s='All products' mod='wishlist_pres'} <i class="material-icons">&#xE315;</i></a>