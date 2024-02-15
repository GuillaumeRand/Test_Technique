{extends file='page.tpl'}

{block name='page_header_container'}
<script type="text/javascript">
    var addProductToCartUrl = '{$addProductToCartUrl nofilter}';
    var confirm_delete_product_text= '{l s='Do you want to delete this product?' mod='wishlist_pres' js=1}';
</script>
{/block}

{block name='page_content_container'}
  <div class="wishlist-products-container">
        {$list_products nofilter}
  </div>
{/block}
{block name='page_footer_container'}
  <div class="wishlist-footer-links">
    <a href="{$wishlistsLink|escape:'html':'UTF-8'}"><i class="material-icons">chevron_left</i>{l s='Return to wish lists' mod='wishlist_pres'}</a>
    <a href="{$urls.base_url|escape:'html':'UTF-8'}"><i class="material-icons">home</i>{l s='Home' mod='wishlist_pres'}</a>
  </div>
{/block}