
{if $tag}
<{$tag|escape:'html':'UTF-8'}
    {if $tag_class} class="{$tag_class|escape:'html':'UTF-8'}"{/if}
    {if $tag_id} id="{$tag_id|escape:'html':'UTF-8'}"{/if}
    {if $rel} rel="{$rel|escape:'html':'UTF-8'}"{/if}
    {if $type} type="{$type|escape:'html':'UTF-8'}"{/if}
    {if $data_id_product} data-id_product="{$data_id_product|escape:'html':'UTF-8'}"{/if}
    {if $value} value="{$value|escape:'html':'UTF-8'}"{/if}
    {if $href} href="{$href nofilter}"{/if}{if $tag=='a' && $blank} target="_blank"{/if}
    {if $tag=='img' && $src} src="{$src nofilter}"{/if}
    {if $attr_name} name="{$attr_name|escape:'html':'UTF-8'}"{/if}
    {if $attr_datas}
        {foreach from=$attr_datas item='data'}
            {$data.name|escape:'html':'UTF-8'}="{$data.value|escape:'html':'UTF-8'}"
        {/foreach}
    {/if}
    {if $tag=='img' || $tag=='br' || $tag=='input'} /{/if}
    
>
    {/if}{if $tag && $tag!='img' && $tag!='input' && $tag!='br' && !is_null($content)}{$content nofilter}{/if}{if $tag && $tag!='img' && $tag!='input' && $tag!='br'}</{$tag|escape:'html':'UTF-8'}>{/if}