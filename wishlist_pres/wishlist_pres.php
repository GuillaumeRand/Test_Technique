<?php

if (!defined('_PS_VERSION_')) {
    exit;
}
require_once(dirname(__FILE__) . '/classes/wl_wishlist.php');
require_once(dirname(__FILE__) . '/classes/wl_paggination_class.php');
class wishlist_pres extends Module
{
    public $hooks = array(
        'displayHeader',
        'Header',
        'displayCustomerAccount',
        'displayBeforeBodyClosingTag',
    );
    public $_errors = array();
    public function __construct()
    {
        $this->name = 'wishlist_pres';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Guillaume Rand';
        $this->need_instance = 0;
        $this->bootstrap = true;
        parent::__construct();
        $this->displayName = $this->l('Wish list');
        $this->description = $this->l('Module allowing the user to add one or more products to one or more wish lists');
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }
    public function install()
    {
        return parent::install() && $this->installHooks();
    }
    public function unInstall()
    {
        return parent::unInstall()  && $this->unInstallHooks();
    }

    public function installHooks()
    {
        foreach ($this->hooks as $hook)
            $this->registerHook($hook);
        return true;
    }
    public function unInstallHooks()
    {
        foreach ($this->hooks as $hook)
            $this->unregisterHook($hook);
        return true;
    }
    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path . '/views/js/front.js');
        $this->context->controller->addCSS($this->_path . '/views/css/front.css');
        $this->context->controller->addCSS($this->_path . '/views/css/wishlist.css');
        $module = Tools::getValue('module');
        if ($module == $this->name) {
            $this->context->controller->addCSS($this->_path . '/views/css/page.css');
        }
        if (file_exists(dirname(__FILE__) . '/views/css/custom.css')) {
            $this->context->controller->addCSS($this->_path . '/views/css/custom.css');
        }
    }
    public function hookDisplayCustomerAccount(array $params)
    {
        $this->smarty->assign([
            'list_wishlist_url' => $this->context->link->getModuleLink($this->name, 'lists'),
            'title_wishlist_page' => Configuration::get('WL_MY_WISHLISTS', $this->context->language->id),
        ]);
        return $this->display(__FILE__, 'displayCustomerAccount.tpl');
    }
    public function hookDisplayBeforeBodyClosingTag($params)
    {
        if ($this->context->customer->isLogged()) {
            $this->smarty->assign(
                array(
                    'list_wishlists' => $this->getAllWishList(),
                    'link_new_wishlist' => $this->context->link->getModuleLink($this->name, 'action', array('action' => 'createNewWishlist')),
                    'link_add_product_to_wishlist' => $this->context->link->getModuleLink($this->name, 'action', array('action' => 'addProductToWishList'))
                )
            );
            return $this->display(__FILE__, 'wishlist_popup.tpl');
        } else {
            $this->smarty->assign(
                array(
                    'link_login' => $this->context->link->getPageLink('authentication'),
                )
            );
            return $this->display(__FILE__, 'login_popup.tpl');
        }
    }
    public function getAllWishList()
    {
        $infos = wl_wishList::getAllWishListsByIdCustomer($this->context->customer->id);
        if (empty($infos)) {
            $wishlist = new wl_wishList();
            $wishlist->id_shop = $this->context->shop->id;
            $wishlist->id_shop_group = $this->context->shop->id_shop_group;
            $wishlist->id_customer = $this->context->customer->id;
            $wishlist->name = Configuration::get('WL_DEFAULT_TITLE', $this->context->language->id) ?: $this->l('My wishlist');
            $wishlist->token = $this->generateWishListToken();
            $wishlist->default = 1;
            $wishlist->add();
            $infos = wl_wishList::getAllWishListsByIdCustomer($this->context->customer->id);
        }
        foreach ($infos as $key => $wishlist) {
            $infos[$key]['listUrl'] = $this->context->link->getModuleLink($this->name, 'view', ['id_wishlist' => $wishlist['id_wishlist']]);
            $infos[$key]['deleteUrl'] = $this->context->link->getModuleLink($this->name, 'action', ['action' => 'deleteWishlist', 'id_wishlist' => $wishlist['id_wishlist']]);
        }
        return $infos;
    }
    public function generateWishListToken()
    {
        return Tools::strtoupper(substr(sha1(uniqid((string) rand(), true) . _COOKIE_KEY_ . $this->context->customer->id), 0, 16));
    }
    public function hasReadAccessToWishlist($wishlist)
    {
        if (!empty($wishlist->token) && Tools::getIsset('token')) {
            return true;
        }
        return $this->hasWriteAccessToWishlist($wishlist);
    }

    /**
     * @return bool
     */
    public function hasWriteAccessToWishlist($wishlist)
    {
        if (false === Validate::isLoadedObject($this->context->customer)) {
            return false;
        }
        return ((int) $wishlist->id_customer) == $this->context->customer->id;
    }
    public static function productsForTemplate($products, Context $context = null)
    {
        if (!$products || !is_array($products))
            return array();
        if (!$context)
            $context = Context::getContext();
        $assembler = new ProductAssembler($context);
        $presenterFactory = new ProductPresenterFactory($context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $presenter = new PrestaShop\PrestaShop\Core\Product\ProductListingPresenter(
            new PrestaShop\PrestaShop\Adapter\Image\ImageRetriever(
                $context->link
            ),
            $context->link,
            new PrestaShop\PrestaShop\Adapter\Product\PriceFormatter(),
            new PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever(),
            $context->getTranslator()
        );

        $products_for_template = array();

        foreach ($products as $rawProduct) {
            $products_for_template[] = $presenter->present(
                $presentationSettings,
                $assembler->assembleProduct($rawProduct),
                $context->language
            );
        }
        return $products_for_template;
    }
    public function displayText($content, $tag, $class = null, $id = null, $href = null, $blank = false, $src = null, $name = null, $value = null, $type = null, $data_id_product = null, $rel = null, $attr_datas = null)
    {
        $this->smarty->assign(
            array(
                'content' => $content,
                'tag' => $tag,
                'tag_class' => $class,
                'tag_id' => $id,
                'href' => $href,
                'blank' => $blank,
                'src' => $src,
                'attr_name' => $name,
                'value' => $value,
                'type' => $type,
                'data_id_product' => $data_id_product,
                'attr_datas' => $attr_datas,
                'rel' => $rel,
            )
        );
        return $this->display(__FILE__, 'html.tpl');
    }
    public function displayPaggination($limit, $name)
    {
        $controller = Tools::getValue('controller');
        if ($controller != 'view' && $controller != 'action') {
            $this->context->smarty->assign(
                array(
                    'limit' => $limit,
                    'pageName' => $name,
                )
            );
            return $this->display(__FILE__, 'limit.tpl');
        }
    }
    public function displayListProductsByWishlist($wishlist)
    {
        $page = (int)Tools::getValue('page');
        if ($page <= 0)
            $page = 1;
        $totalRecords = (int)$wishlist->getProductsOrCount('total');
        $paggination = new wl_paggination_class();
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getModuleLink($this->name, 'view', array_merge($this->getViewAccessParams(), array('page' => '_page_')));
        $paggination->limit = (int)Configuration::get('PS_PRODUCTS_PER_PAGE') ?: 12;
        $paggination->name = 'products';
        $totalPages = ceil($totalRecords / $paggination->limit);
        if ($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if ($start < 0)
            $start = 0;
        $sort = 'cp.position asc';
        if ($sortorder = Tools::getValue('order')) {
            switch (Tools::strtolower($sortorder)) {
                case 'product.name.asc':
                    $sort = 'pl.name asc';
                    break;
                case 'product.name.desc':
                    $sort = 'pl.name desc';
                    break;
                case 'product.price.asc':
                    $sort = 'p.price asc';
                    break;
                case 'wishlist_product.id_wishlist_product.desc':
                    $sort = 'id_wishlist_product desc';
                    break;
            }
        }
        $products = $wishlist->getProductsOrCount('products', $sort, $start, $paggination->limit);
        $products = wishlist_pres::productsForTemplate($products);
        $this->smarty->assign(
            array(
                'id_wishlist' => $wishlist->id,
                'link' => $this->context->link,
                'wishlistName' => $wishlist->name,
                'totalRecords' => $totalRecords,
                'isGuest' => !$this->hasWriteAccessToWishlist($wishlist),
                'urlView' => Context::getContext()->link->getModuleLink($this->name, 'view', $this->getViewAccessParams()),
                'wishlistsLink' => Context::getContext()->link->getModuleLink($this->name, 'lists'),
                'deleteProductUrl' => Context::getContext()->link->getModuleLink($this->name, 'action', ['action' => 'deleteProductFromWishlist']),
                'addProductToCartUrl' => Context::getContext()->link->getModuleLink($this->name, 'action', ['action' => 'addProductToCart']),
                'products' => $products,
                'sortOrder' => Tools::strtolower($sortorder),
                'paggination' => $paggination->render(),
            )
        );
        return $this->display(__FILE__, 'products-list.tpl');
    }
    private function getViewAccessParams()
    {
        if (Tools::getIsset('token')) {
            return ['token' => Tools::getValue('token')];
        }
        if (($id_wishlist = (int)Tools::getValue('id_wishlist'))) {
            return ['id_wishlist' => $id_wishlist];
        }

        return [];
    }
    public function displayBlockWishlist($id_wishlist, $position)
    {
        $wishlist = new wl_wishList($id_wishlist);
        $nbProduct = Configuration::get('WLP_NUMBER_PRODUCT_IN_' . Tools::strtoupper($position)) ?: false;
        $products = $wishlist->getProductsOrCount('products', 'cp.position asc', 0, $nbProduct);
        $products = wishlist_pres::productsForTemplate($products);
        if (Tools::isSubmit('ajax')) {
            $page = array(
                'page_name' => Tools::getValue('page_name'),
            );
            $this->smarty->assign('page', $page);
        }
        $this->smarty->assign(
            array(
                'products' => $products,
                'ajax' => Tools::isSubmit('ajax'),
                'blockName' => $position,
                'wlp_display_type' => Configuration::get('WLP_DISPLAY_TYPE_IN_' . Tools::strtoupper($position)) ?: 'gird',
                'allWishlistProductsLink' => $this->context->link->getModuleLink($this->name, 'view', array('id_wishlist' => $id_wishlist)),
                'slide_auto_play' => Configuration::get('WLP_AUTO_PLAY_' . Tools::strtoupper($position)),
            )
        );
        return $this->display(__FILE__, 'block_products_list.tpl');
    }
}
