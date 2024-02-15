<div class="limit results">
    <label class="" for="paginator_select_limit">{l s='Items per page:' mod='wishlist_pres'}</label>
    <div>
        <select id="paginator_{$pageName|escape:'html':'UTF-8'}_select_limit" class="pagination-link custom-select paginator_select_limit" name="paginator_{$pageName|escape:'html':'UTF-8'}_select_limit" >
            <option value="10" {if $limit==10} selected="selected"{/if}>10</option>
            <option value="20" {if $limit==20} selected="selected"{/if}>20</option>
            <option value="50" {if $limit==50} selected="selected"{/if}>50</option>
            <option value="100" {if $limit==100} selected="selected"{/if}>100</option>
            <option value="300" {if $limit==300} selected="selected"{/if}>300</option>
        </select>
    </div>
</div>