{extends file='page.tpl'}
{block name='page_header_container'}
    <script type="text/javascript">
        var confirm_delete_wishlist_text= '{l s='Do you want to delete this wish list?' mod='wishlist_pres' js=1}';
        var View_text = {l s='View' mod='wishlist_pres' js=1};
        var Copy_link_text ='{l s='Copy link' mod='wishlist_pres' js=1}';
        var Delete_text ='{l s='Delete' mod='wishlist_pres' js=1}';
    </script>
{/block}
{block name='page_content_container'}
  <div class="wishlist-container">
    <section id="content" class="page-content card card-block">
        <div class="wishlist-container-header" >
            <h1 >{$wishlistsTitlePage|escape:'html':'UTF-8'}</h1>
            <a class="wishlist-add-to-new">
                <i class="material-icons">add_circle_outline</i>
                {$newWishlistCTA|escape:'html':'UTF-8'}
            </a>
        </div>
        <table class="table">
            <thead>
                <tr class="nodrag nodrop">
                    <th class="whislist-name">{l s='Name' mod='wishlist_pres'}</th>
                    <th class="products">{l s='Products' mod='wishlist_pres'}</th>
                    <th class="wishlist-list-item-right">{l s='Action' mod='wishlist_pres'}</th>
                </tr>
            </thead>
            <tbody class="wishlist-list">
                {if $wishlists}
                    {foreach from=$wishlists item='wishlist'}
                        <tr class="wishlist-list-item{if $wishlist.default} wishlist-list-item-default{/if}" data-id="{$wishlist.id_wishlist|intval}" data-name="{$wishlist.name|escape:'html':'UTF-8'}">
                            <td class="whislist-name">
                                <a class="wishlist-list-item-link" href="{$wishlist.listUrl|escape:'html':'UTF-8'}">
                                    <p class="wishlist-list-item-title">
                                        <span class="wishlist_name">{$wishlist.name|escape:'html':'UTF-8'}</span>
                                    </p>
                                </a>
                            </td>
                            <td class="products">
                                {if $wishlist.products}
                                    {$wishlist.products nofilter}
                                {else}
                                    --
                                {/if}
                            </td>
                            <td class="wishlist-list-item-right">
                                <a title="{l s='View' mod='wishlist_pres'}" class="link-view-wishlist" href="{$wishlist.listUrl|escape:'html':'UTF-8'}">
                                    <i><svg style="width:14px; height:14px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--! Font Awesome Pro 6.1.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z"/></svg></i>
                                </a>
                                {if !$wishlist.default}
                                    <button title="{l s='Delete' mod='wishlist_pres'}" class="wishlist-btn-delete" data-url-delete="{$wishlist.deleteUrl nofilter}">
                                        <i><svg style="width:14px; height:14px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--! Font Awesome Pro 6.1.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. --><path d="M135.2 17.69C140.6 6.848 151.7 0 163.8 0H284.2C296.3 0 307.4 6.848 312.8 17.69L320 32H416C433.7 32 448 46.33 448 64C448 81.67 433.7 96 416 96H32C14.33 96 0 81.67 0 64C0 46.33 14.33 32 32 32H128L135.2 17.69zM394.8 466.1C393.2 492.3 372.3 512 346.9 512H101.1C75.75 512 54.77 492.3 53.19 466.1L31.1 128H416L394.8 466.1z"/></svg></i>
                                    </button>
                                {/if}

                            </td>
                        </tr>
                    {/foreach}
                {/if}
            </tbody>
        </table>
    </section>
  </div>
  {include file="module:wishlist_pres/views/templates/hook/share.tpl" url=$shareUrl}
  {include file="module:wishlist_pres/views/templates/hook/rename.tpl" url=$renameUrl}
{/block}


{block name='page_footer_container'}
  <div class="wishlist-footer-links">
    <a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}"><i class="material-icons">chevron_left</i>{l s='Return to your account' mod='wishlist_pres'}</a>
    <a href="{$urls.base_url|escape:'html':'UTF-8'}"><i class="material-icons">home</i>{l s='Home' mod='wishlist_pres'}</a>
  </div>
{/block}