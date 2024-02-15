<div class="wishlist-login">
    <div  tabindex="-1" role="dialog" aria-modal="true" class="wishlist-modal modal fade">
        <div class="modal-dialog modal-dialog-centered">
            <div  class="modal-content">
                <div  class="modal-header">
                    <h5  class="modal-title">{l s='Sign in' mod='wishlist_pres'}</h5> 
                    <button  type="button" data-dismiss="modal" class="close" title="{l s='Close' mod='wishlist_pres'}">
                        <span  aria-hidden="true">×</span>
                    </button>
                </div> 
                <div  class="modal-body">
                    <p  class="modal-text">{l s='You need to be logged in to save products in your wish list.' mod='wishlist_pres'}</p>
                </div> 
                <div  class="modal-footer">
                    <button  type="button" data-dismiss="modal" class="modal-cancel btn btn-secondary">
                        {l s='Cancel' mod='wishlist_pres'}
                    </button> 
                    <a  type="button" href="{$link_login|escape:'html':'UTF-8'}" class="btn btn-primary">
                        {l s='Sign in' mod='wishlist_pres'}
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div  class="modal-backdrop fade"></div>
 </div>