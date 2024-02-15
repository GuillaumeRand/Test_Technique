<div class="wishlist-add-to" data-url="{$link_add_product_to_wishlist nofilter}">
    <div tabindex="-1" role="dialog" aria-modal="true" class="wishlist-modal modal fade">
        <div  role="document" class="modal-dialog modal-dialog-centered">
            <div  class="modal-content">
                <div  class="modal-header">
                    <h5 class="modal-title">
                        {l s='Add to wish list' mod='wishlist_pres'}
                    </h5> 
                    <button type="button" data-dismiss="modal" class="close" title="{l s='Close' mod='wishlist_pres'}">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="wl_id_product_current" value="" id="wl_id_product_current"/>
                    <input type="hidden" name="wl_id_product_attribute_current" value="" id="wl_id_product_attribute_current"/>
                    
                    <div class="wishlist-chooselist">
                        <ul class="wishlist-list">
                            {if $list_wishlists}
                                {foreach from = $list_wishlists item='wishlist'}
                                    <li class="item-wishlist" data-id="{$wishlist.id_wishlist|intval}"><p>{$wishlist.name|escape:'html':'UTF-8'}</p></li>
                                {/foreach}
                            {/if} 
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                <a class="wishlist-add-to-new">
                    <i  class="material-icons">add_circle_outline</i> {l s='Create new list' mod='wishlist_pres'}
                </a>
                </div>
            </div>
        </div>
    </div>
    <div  class="modal-backdrop fade">
    </div>
</div>
<div data-url="{$link_new_wishlist nofilter}" class="wishlist-create">
    <div tabindex="-1" role="dialog" aria-modal="true" class="wishlist-modal modal fade">
        <div  role="document" class="modal-dialog modal-dialog-centered">
            <div  class="modal-content">
                <div  class="modal-header">
                    <h5  class="modal-title">{l s='Create wish list' mod='wishlist_pres'}</h5>
                    <button  type="button" data-dismiss="modal" class="close" title="{l s='Close' mod='wishlist_pres'}">
                        <span  aria-hidden="true">×</span>
                    </button>
                </div> 
                <div  class="modal-body">
                    <div  class="form-group form-group-lg">
                        <label  for="wishlist_name" class="form-control-label required">{l s='Wish list name' mod='wishlist_pres'} </label>
                        <input name="wishlist_name" id="wishlist_name" placeholder="{l s='Add name' mod='wishlist_pres'}" class="form-control form-control-lg" type="text" />
                    </div>
                </div> 
                <div  class="modal-footer">
                    <button  type="button" data-dismiss="modal" class="modal-cancel btn btn-secondary">
                        {l s='Cancel' mod='wishlist_pres'}   
                    </button>
                    <button  type="button" class="btn btn-primary btn-submit-new-wishlist">
                        {l s='Create wish list' mod='wishlist_pres'}
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div  class="modal-backdrop fade"></div>
</div>
<div class="wishlist-toast" data-required="{l s='Wish list name is required' mod='wishlist_pres'}">
    <p class="wishlist-toast-text"> </p>
</div>